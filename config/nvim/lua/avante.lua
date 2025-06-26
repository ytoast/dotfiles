-- Avante.nvim AI Assistant Configuration
-- 
-- ==================== SETUP INSTRUCTIONS ====================
-- 
-- 1. Install plugins: Run `:PlugInstall` in Neovim
-- 2. Build avante: Build happens automatically with 'do': 'make'
-- 3. Set environment variables in your ~/.zshrc or ~/.zprofile:
--
-- Required Environment Variables (Scoped Keys - Recommended):
--   export AVANTE_ANTHROPIC_API_KEY=sk-ant-api03-...
--   export AVANTE_OPENAI_API_KEY=sk-...
--   export AVANTE_COPILOT_API_KEY=your-copilot-key  # if using copilot provider
--
-- Alternative Global Keys (if preferred):
--   export ANTHROPIC_API_KEY=sk-ant-api03-...
--   export OPENAI_API_KEY=sk-...
--
-- 4. Restart your terminal after adding environment variables
-- 5. Test with `:AvanteAsk` or `<leader>aa`
--
-- ==================== KEY BINDINGS ====================
-- <leader>aa - Show sidebar / Ask AI
-- <leader>ae - Edit selected code blocks  
-- <leader>ar - Refresh sidebar
-- <leader>af - Switch sidebar focus
-- <leader>at - Toggle sidebar visibility
-- ========================================================

-- Setup dependencies (with error handling)
local function safe_require(module, setup_func)
  local ok, mod = pcall(require, module)
  if ok and setup_func then
    setup_func(mod)
  elseif not ok then
    vim.notify("Failed to load " .. module .. ": " .. mod, vim.log.levels.WARN)
  end
  return ok, mod
end

-- Setup img-clip
safe_require('img-clip', function(img_clip)
  img_clip.setup({
    default = {
      embed_image_as_base64 = false,
      prompt_for_file_name = false,
      drag_and_drop = {
        insert_mode = true,
      },
      use_absolute_path = true,
    },
  })
end)

-- Setup copilot
safe_require('copilot', function(copilot)
  copilot.setup({
    -- Your existing copilot settings
  })
end)

-- Setup render-markdown
safe_require('render-markdown', function(render_md)
  render_md.setup({
    file_types = { "markdown", "Avante" },
  })
end)

-- Setup avante (main configuration)
safe_require('avante', function(avante)
  -- Load avante_lib if available
  pcall(function()
    require('avante_lib').load()
  end)
  
  -- Always setup avante to avoid nil config errors
  avante.setup({
    -- Provider configuration
    provider = "claude", -- "claude", "openai", "copilot"
    auto_suggestions_provider = "copilot", -- Use copilot for auto-suggestions since you already have it
    
    -- Provider-specific configurations
    providers = {
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,
      },
      openai = {
        endpoint = "https://api.openai.com/v1/chat/completions",
        model = "gpt-4o",
        timeout = 30000,
        temperature = 0,
        max_tokens = 4096,
      },
    },
    
    -- Behavior settings
    behaviour = {
      auto_suggestions = false, -- Keep disabled for now (experimental)
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
      minimize_diff = true,
    },
    
    -- Key mappings
    mappings = {
      ask = "<leader>aa",          -- Show sidebar
      edit = "<leader>ae",         -- Edit selected blocks
      refresh = "<leader>ar",      -- Refresh sidebar
      focus = "<leader>af",        -- Switch sidebar focus
      toggle = "<leader>at",       -- Toggle sidebar visibility
      submit = {
        normal = "<CR>",
        insert = "<C-s>",
      },
      cancel = {
        normal = { "<C-c>", "<Esc>" },
        insert = { "<C-c>" },
      },
    },
    
    -- UI settings
    hints = { enabled = true },
    windows = {
      position = "right", -- "right", "left", "top", "bottom"
      wrap = true,
      width = 30, -- % based on available width
      sidebar_header = {
        enabled = true,
        align = "center", -- "left", "center", "right"
        rounded = true,
      },
      input = {
        prefix = "> ",
        height = 8,
      },
      edit = {
        border = "rounded",
        start_insert = true,
      },
      ask = {
        floating = false,
        start_insert = true,
        border = "rounded",
        focus_on_apply = "ours", -- "ours" | "theirs"
      },
    },
  })
end)

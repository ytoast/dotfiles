-- DEFAULTS, to decide if you want
-- -- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- -- set termguicolors to enable highlight groups
-- vim.opt.termguicolors = true

-- -- empty setup using defaults
-- require("nvim-tree").setup()

--Tree

require'nvim-tree'.setup {
  -- disable_netrw       = true,
  hijack_netrw        = true,
  -- open_on_setup       = false,
  -- auto_close          = false,
  -- open_on_tab         = false,
  -- hijack_cursor       = false,
  -- update_cwd          = false,
  diagnostics = {
    enable = false,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = true,
    update_cwd  = true,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = true,
    custom = {}
  },
  view = {
    width = 45,
  }
}

vim.api.nvim_set_keymap("n", "<leader>m", ":NvimTreeToggle<CR>", {silent = true, noremap = true})

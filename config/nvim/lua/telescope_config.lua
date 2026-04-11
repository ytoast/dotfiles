local telescope = require('telescope')
telescope.setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      "%.git/",
      "%.worktrees/",
      "%.claude/worktrees/",
    }
  },
  -- extensions = {
  --   file_browser = {
  --     cwd = vim.g.documentos,
  --     theme = "ivy",
  --     -- disables netrw and use telescope-file-browser in its place
  --     hijack_netrw = true,
  --     mappings = {
  --       ["i"] = {
  --         -- your custom insert mode mappings
  --       },
  --       ["n"] = {
  --         -- your custom normal mode mappings
  --       },
  --     },
  --   },
  -- },
}
-- telescope.extensions.file_browser.file_browser({
--     cwd =vim.g.documentos,
-- })

_G.with_preview = {
  border = true,
  layout_strategy = "horizontal",
  layout_config = {
    height = 0.9,
    width = 0.9,
    prompt_position = "top",
  },
  sorting_strategy = "ascending",
  find_command = {
    'rg',
    '--files',
    '--glob=!.git',
    '--glob=!.worktrees',
    '--glob=!.claude/worktrees',
  },
}

_G.no_preview = function()
  return require('telescope.themes').get_ivy({
    layout_config = {
      width = 0.8,
    },
    previewer = false,
    find_command = {
      'rg',
      '--ignore',
      '--hidden',
      '--files',
      '--glob=!.git',
      '--glob=!.worktrees',
      '--glob=!.claude/worktrees',
    },
  })
end

-- Pick a worktree and search files within it
_G.find_in_worktree = function()
  local worktrees = {}
  local main_cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  local lines = vim.fn.systemlist('git worktree list --porcelain')
  for _, line in ipairs(lines) do
    local path = line:match('^worktree (.+)$')
    if path and path ~= main_cwd then
      table.insert(worktrees, path)
    end
  end

  if #worktrees == 0 then
    print("No worktrees found")
    return
  end

  -- Show short display names but map back to full paths
  local display = {}
  for _, path in ipairs(worktrees) do
    table.insert(display, vim.fn.fnamemodify(path, ':t') .. '  (' .. path .. ')')
  end

  vim.ui.select(display, { prompt = 'Worktree: ' }, function(choice, idx)
    if choice and idx then
      local selected_path = worktrees[idx]
      require('telescope.builtin').find_files(vim.tbl_extend('force', no_preview(), {
        cwd = selected_path,
        prompt_title = 'Files in ' .. vim.fn.fnamemodify(selected_path, ':t'),
        find_command = { 'rg', '--ignore', '--hidden', '--files' },
      }))
    end
  end)
end

vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files(with_preview)<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader><leader>', "<cmd>lua require('telescope.builtin').find_files(no_preview())<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep(with_preview)<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>gb', "<cmd>lua require('telescope.builtin').git_branches()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>,', "<cmd>lua require('telescope.builtin').buffers()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>wf', "<cmd>lua find_in_worktree()<cr>", {silent=true, noremap=true})

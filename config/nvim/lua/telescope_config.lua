local telescope = require('telescope')
telescope.setup {
  defaults = { file_ignore_patterns = {"node_modules"} },
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
    -- '--ignore',
    -- '--hidden',
    '--files',
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
    },
  })
end

vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>lua require('telescope.builtin').find_files(with_preview)<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader><leader>', "<cmd>lua require('telescope.builtin').find_files(no_preview())<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fg', "<cmd>lua require('telescope.builtin').live_grep(with_preview)<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>fb', "<cmd>lua require('telescope.builtin').buffers()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>gb', "<cmd>lua require('telescope.builtin').git_branches()<cr>", {silent=true, noremap=true})
vim.api.nvim_set_keymap('n', '<leader>,', "<cmd>lua require('telescope.builtin').buffers()<cr>", {silent=true, noremap=true})

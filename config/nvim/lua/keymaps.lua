-- Use ctrl-[hjkl] to select the active split
vim.api.nvim_set_keymap('n', '<c-k>', ':wincmd k<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<c-j>', ':wincmd j<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<c-h>', ':wincmd h<CR>', {silent = true, noremap = true})
vim.api.nvim_set_keymap('n', '<c-l>', ':wincmd l<CR>', {silent = true, noremap = true})


vim.keymap.set('n', '<leader>k', ':vertical resize +10<CR>', { silent = true })
vim.keymap.set('n', '<leader>j', ':vertical resize -10<CR>', { silent = true })

-- Black formatter binding
vim.keymap.set('n', '<space>b', ':Black<CR>', { silent = true, desc = 'Format with Black' })
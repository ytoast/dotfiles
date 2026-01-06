-- Options (previously in vimrc)

local opt = vim.opt
local g = vim.g

-- Python provider
g.python3_host_prog = vim.fn.expand('~/.virtualenvs/neovim/bin/python')

-- Deoplete
g.deoplete_enable_at_startup = 1

-- Disable concealing in JSON and Markdown
g.vim_json_conceal = 0
g.vim_md_conceal = 0

-- Backup and swap
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- Tabs and indentation
opt.expandtab = true
opt.smarttab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.shiftround = true

-- Line wrapping
opt.linebreak = true
opt.textwidth = 500
opt.autoindent = true
opt.smartindent = true
opt.wrap = true

-- Search
opt.hlsearch = true

-- Display
opt.termguicolors = true
opt.relativenumber = true
opt.number = true
opt.scrolloff = 4
opt.signcolumn = 'yes'
opt.mouse = 'c'

-- Grep
opt.grepprg = 'rg --vimgrep'
opt.grepformat:prepend('%f:%l:%c:%m')

-- FZF (if installed via homebrew)
opt.rtp:append('/usr/local/opt/fzf')

-- Colorscheme
vim.cmd('colorscheme evergarden')

-- Keymaps
local map = vim.keymap.set

-- Fast saving
map({'n', 'i'}, '<C-s>', '<Esc>:w<CR>')

-- Buffer navigation
map('n', '<Tab>', ':bnext!<CR>', { silent = true })
map('n', '<S-Tab>', ':bprev!<CR>', { silent = true })

-- Close current buffer
map('n', '<leader>bq', ':bp <bar> bd! #<CR>', { silent = true })

-- LazyGit
map('n', '<leader>gg', ':LazyGit<CR>', { silent = true })

-- Edit config files
map('n', '<leader>vi', ':tabedit ~/.config/nvim/init.lua<CR>')
map('n', '<leader>so', ':source ~/.config/nvim/init.lua<CR>')

-- Copy to system clipboard
map('v', '<C-c>', '"+y')

-- EasyAlign
map('x', 'ga', '<Plug>(EasyAlign)')
map('n', 'ga', '<Plug>(EasyAlign)')

-- Autocmds
local augroup = vim.api.nvim_create_augroup('UserConfig', { clear = true })

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd('BufWritePre', {
  group = augroup,
  pattern = '*',
  callback = function()
    local save_cursor = vim.fn.getpos('.')
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos('.', save_cursor)
  end,
})

-- SQL comment string
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'sql',
  callback = function()
    vim.opt_local.commentstring = '-- %s'
  end,
})

-- Jinja files use SQL syntax
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup,
  pattern = '*.jinja',
  callback = function()
    vim.opt_local.syntax = 'sql'
  end,
})

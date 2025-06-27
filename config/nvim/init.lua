vim.opt.termguicolors = true

-- Set runtimepath
vim.opt.runtimepath:prepend("~/.vim")
vim.opt.runtimepath:append("~/.vim/after")

-- Set packpath
vim.opt.packpath:prepend("~/.vim")
vim.opt.packpath:append("~/.vim/after")

-- Source .vimrc
vim.cmd('source ~/.vimrc')

-- Require other Lua modules
require('lsp_config')
require('hop_config')
require('formatter_config')
require('telescope_config')
require('treesitter')
require('status_line')
require('highlight')
require('dbtpal')
require('nvim_tree')
require('keymaps')
require('evergarden_config')
require('bufferline_simple')
require('toggleterm_config')

require('avante')  -- Commented out as in the original init.vim

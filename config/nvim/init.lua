vim.opt.termguicolors = true

-- Set leader key before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins via lazy.nvim
require("lazy").setup("plugins")

-- Source .vimrc for non-plugin settings
vim.cmd('source ~/.vimrc')

-- Require other Lua modules
require('lsp_config')
require('hop_config')
require('formatter_config')
require('telescope_config')
require('status_line')
require('highlight')
require('dbtpal')
require('nvim_tree')
require('keymaps')
require('evergarden_config')
require('bufferline_simple')
require('toggleterm_config')

require('avante')  -- Commented out as in the original init.vim

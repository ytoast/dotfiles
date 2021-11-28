set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua require('lsp_config')
lua require('telescope_config')
lua require('treesitter')

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

lua require('lsp_config')
lua require('hop_config')
lua require('formatter_config')
lua require('telescope_config')
lua require('treesitter')
lua require('status_line')
lua require('highlight')
lua require('dbtpal')
lua require('nvim_tree')

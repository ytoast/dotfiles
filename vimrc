call plug#begin('~/.vim/plugged')
" Colorschemes
Plug 'gosukiwi/vim-atom-dark'

Plug 'nvim-lua/plenary.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'Yggdroot/indentLine'
" Plug 'blueyed/vim-diminactive'
Plug 'akinsho/bufferline.nvim'
" Python
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'psf/black'
" All languages syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'christianchiarulli/nvcode-color-schemes.vim'

" LSP
Plug 'neovim/nvim-lspconfig'
call plug#end()

colorscheme atom-dark
syntax on

" MAPPING
let g:deoplete#enable_at_startup = 1
let g:python3_host_prog = expand('~/.virtualenvs/neovim/bin/python')
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"
map <C-s> <esc>:w<CR>    " Fast saving
imap <C-s> <esc>:w<CR>
nmap <C-s> :w<cr>

" Switch buffers with tab
nnoremap <Tab> :bnext!<CR>
nnoremap <S-Tab> :bprev!<CR>

"close current buffer
nnoremap <leader>bq :bp <bar> bd! #<cr>

"close all open buffers
nnoremap <leader>bqa :%bd!<cr>

nmap <leader>vi :tabedit ~/.vimrc<cr>             " Edit your vimrc in a new tab
nmap <leader>so :source $MYVIMRC<cr>              " Source (reload) your vimrc

set nobackup
set nowritebackup
set nowb
set noswapfile

set expandtab  " Use spaces instead of tabs
set smarttab   " Be smart when using tabs
" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2
set shiftround " When at 3 spaces and I hit >>, go to 4, not 5.

" Linebreak on 500 characters
set lbr
set tw=500
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Also switch on highlighting the last used search pattern.
set hlsearch
set termguicolors

" Delete trailing white space on save, useful for Python and CoffeeScript
func! DeleteTrailingWS()
exe "normal mz"
%s/\s\+$//ge
exe "normal `z"
endfunc
autocmd BufWrite *.hs :call DeleteTrailingWS()
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

autocmd BufWritePre * :%s/\s\+$//e   " Remove trailing whitespaces

" Copy to system clipboard
vnoremap <C-c> "+y

" diminactive
" let g:diminactive_enable_focus = 1

" SETTINGS
set relativenumber          " Set relative line numbers
set number                  " Set line numbers
set scrolloff=4             " Keep at least 4 lines below cursor
set signcolumn=yes          " always show signcolumns
set grepprg=rg\ --vimgrep   " Use RipGrep instead of grep
set grepformat^=%f:%l:%c:%m


lua << EOF
-- Bufferline
require("bufferline").setup{}
--Treesitter
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
-- LSP
require'lspconfig'.pyright.setup{}
require'lspconfig'.pylsp.setup{}
-- Telescope
require('telescope').setup{
}
EOF

" Treesitter
nnoremap <leader>ff <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files <cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

set rtp+=/usr/local/opt/fzf

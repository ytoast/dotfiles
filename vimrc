let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Colorschemes
Plug 'gosukiwi/vim-atom-dark'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'everviolet/nvim', { 'as': 'evergarden' }
Plug 'lifepillar/vim-solarized8'

Plug 'nvim-lua/plenary.nvim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-commentary'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-tree/nvim-web-devicons' " optional
Plug 'nvim-tree/nvim-tree.lua'
Plug 'Yggdroot/indentLine'
Plug 'akinsho/bufferline.nvim'
Plug 'phaazon/hop.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'L3MON4D3/LuaSnip'
Plug 'kdheepak/lazygit.nvim'

" Python
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'psf/black'

" All languages syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'christianchiarulli/nvcode-color-schemes.vim'
Plug 'tomlion/vim-solidity'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Pretty
Plug 'nvim-lualine/lualine.nvim'
Plug 'mhartington/formatter.nvim'
Plug 'junegunn/vim-easy-align'

" AI
Plug 'github/copilot.vim'
Plug 'robitx/gp.nvim'
Plug 'stevearc/dressing.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'HakonHarnes/img-clip.nvim'
Plug 'zbirenbaum/copilot.lua'
Plug 'MeanderingProgrammer/render-markdown.nvim'
Plug 'yetone/avante.nvim', { 'branch': 'main', 'do': 'make' }

" DBT
Plug 'PedramNavid/dbtpal'

call plug#end()

" To get colorscheme to appear correctly
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

" colorscheme atom-dark
" let g:tokyonight_style = "night"
" let g:tokyonight_italic_functions = 1
" let g:tokyonight_sidebars = [ "qf", "vista_kind", "terminal", "packer" ]
" colorscheme tokyonight
colorscheme evergarden
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
" nnoremap <leader>bqa :%bd!<cr>

nnoremap <silent> <leader>gg :LazyGit<CR>

nmap <leader>vi :tabedit ~/.vimrc<cr>             " Edit your vimrc in a new tab
nmap <leader>so :source ~/.vimrc<cr>              " Source (reload) your vimrc

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
set nocompatible

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
autocmd FileType sql setlocal commentstring=--\ %s

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
set mouse=c


lua << EOF
require('gitsigns').setup()
EOF

set rtp+=/usr/local/opt/fzf

" To move to lua
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

let g:vim_json_conceal=0
let g:vim_md_conceal=0
au BufReadPost *.jinja set syntax=sql

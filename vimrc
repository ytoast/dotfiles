" Plugins are now managed by lazy.nvim in lua/plugins.lua

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



set rtp+=/usr/local/opt/fzf

" To move to lua
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

let g:vim_json_conceal=0
let g:vim_md_conceal=0
au BufReadPost *.jinja set syntax=sql

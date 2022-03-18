syntax on

set nocompatible
set ruler relativenumber number
set ignorecase smartcase
set errorbells
set tabstop=2 softtabstop=2
set shiftwidth=2
set smartindent
set noswapfile
set nobackup
set nowrap
set undodir=~/.vim/undodir
set undofile
set hlsearch incsearch
set path+=**
set wildmenu

nnoremap gb :ls<cr>:b<space>
nnoremap gt :.!cat<space>~/c_playground/template.c<cr>
filetype plugin on

highlight ColorColumn ctermbg=0 guibg=darkgray

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-fugitive'
Plug 'leafgarland/typescript-vim'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
Plug 'git@github.com:kien/ctrlp.vim.git'
Plug 'git@github.com:valloric/YouCompleteMe.git'
Plug 'mbbill/undotree'

call plug#end()

colorscheme gruvbox

set background=dark

if executable('rg')
	let g:rg_derive_root='true'
endif

let g:ctrlp_user_command = ['.git/']
let mapleader = " "
let g:netrw_browse_split=2
let g:netrw_banner = 0

let g:ctrlp_use_caching = 0
let g:netrw_winsize = 25

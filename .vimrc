" be iMproved
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vim-airline
Plugin 'bling/vim-airline'

" Solarize colorscheme
Plugin 'altercation/vim-colors-solarized'

" Tabularize
Plugin 'godlygeek/tabular'

" Control - P
Plugin 'kien/ctrlp.vim'

call vundle#end()
filetype plugin indent on

" tabs set to 3 spaces
set expandtab
set shiftwidth=3
set tabstop=3
 
" tabs set to 4 spaces for Python files
au FileType python set shiftwidth=4|set tabstop=4
 
" Avoid messing up indentations when copy/pasting
set copyindent
set preserveindent
 
" make sure to show windows end lines
set ff=unix
set ffs=unix
 
" disable automatic comment insertion
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
 
" load colorscheme
syntax enable
set background=dark
set t_Co=256
set term=xterm-256color
let g:solarized_termtrans  = 1
let g:solarized_termcolors = 256
let g:solarized_visibility = "high"
let g:solarized_contrast   = "high"
colorscheme solarized
 
" activate mouse
set mouse=a
 
" display vim-airline
set laststatus=2

" disable replace mode
imap <Insert> <Nop>
inoremap <S-Insert> <Insert>
 
" Tabularize mapping. e.g.: ,t:
let mapleader = ","
nmap <Leader>t= :Tabularize /=<CR>
vmap <Leader>t= :Tabularize /=<CR>
nmap <Leader>t: :Tabularize /:<CR>
vmap <Leader>t: :Tabularize /:<CR>
 
" file jumps as soon as you start to search
set incsearch

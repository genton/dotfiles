" be iMproved
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vim-airline
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Solarize colorscheme
" Plugin 'altercation/vim-colors-solarized'

" Molokai colorscheme
Plugin 'tomasr/molokai'

" Tabularize
Plugin 'godlygeek/tabular'

" Control - P
Plugin 'kien/ctrlp.vim'

" Syntax highlighting for vim
Plugin 'pangloss/vim-javascript'

" Syntax highlighting for jsx
Plugin 'mxw/vim-jsx'

" YouCompleteMe autocompletion
Plugin 'Valloric/YouCompleteMe'

" Rust syntax
Plugin 'rust-lang/rust.vim'

" Rust Racer
Plugin 'racer-rust/vim-racer'

call vundle#end()
filetype plugin indent on

" tabs set to 4 spaces
set expandtab
set shiftwidth=4
set tabstop=4

" tabs set to 4 spaces for Python files
" au FileType python set shiftwidth=4|set tabstop=4

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
set cursorline
set background=dark
set t_Co=256
set term=xterm-256color
"let g:molokai_original = 1
let g:rehash256 = 1
colorscheme molokai
" let g:solarized_termtrans  = 1
" let g:solarized_termcolors = 256
" let g:solarized_visibility = "high"
" let g:solarized_contrast   = "high"
" colorscheme solarized

" activate mouse
" set mouse=a

" display vim-airline
let g:airline_powerline_fonts = 1
set laststatus=2
let g:airline_theme='badwolf'

" disable replace mode
imap <Insert> <Nop>
inoremap <S-Insert> <Insert>

" Tabularize mapping. e.g.: ,t:
let mapleader = ","
nmap <Leader>t= :Tabularize /=<CR>
vmap <Leader>t= :Tabularize /=<CR>
nmap <Leader>t: :Tabularize /:<CR>
vmap <Leader>t: :Tabularize /:<CR>

" file jumps as soon as you start to search and highlights matches
" also cancel a search with Escape
set incsearch
set hlsearch

" reload vim config without having to restart editor
map <leader>s :source ~/.vimrc<CR>

" YouCompleteMe config
let g:ycm_global_ycm_extra_conf = "/home/phate/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
let g:ycm_autoclose_preview_window_after_completion = 1

" Rust Racer config
set hidden
let g:racer_cmd = "~/.cargo/bin/racer"
let $RUST_SRC_PATH="/usr/src/rust/src"
let g:racer_experimental_completer = 1

" italic comments
highlight Comment cterm=italic

" ycm loaded automatically
" let g:ycm_confirm_extra_conf = 0
let g:ycm_extra_conf_globlist = ['~/projects/saccard/.ycm_extra_conf.py']

" keep 12 lines always visible around cursor when scrolling
set scrolloff=12

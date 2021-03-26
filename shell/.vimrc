inoremap jj <ESC>


syntax on
set number

set autoindent " Indents new line
set smartindent " Indent inside brackets

set tabstop=2

set noswapfile
set hlsearch
set ignorecase
set incsearch


call plug#begin('~/.vim/plugged')

Plug 'drewtempelmeyer/palenight.vim'

call plug#end()


" Color scheme
set background=dark
colorscheme palenight
let g:lightline = { 'colorscheme': 'palenight' }
let g:airline_theme = "palenight"
let g:palenight_terminal_italics=1

" True colors configuration
if (has("termguicolors"))
  set termguicolors
endif


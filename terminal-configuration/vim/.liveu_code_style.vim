" This file is used for code style options
" It is turned on from main vimrc: source ~/.vim/.code_style.vim
" To enable it:
" ln -s <absolute path to this directory>/.default_code_style.vim <absolute path to home directory>/.vim/.code_style.vim

syntax on
"filetype plugin indent on
set number
set smartindent
set tabstop=4
set shiftwidth=4
"set expandtab " to insert spaces instead of tabs
set noexpandtab " global for all types of file
set incsearch
set softtabstop=4
set autoindent
set ignorecase
set smartcase
set cindent
set backspace=indent,eol,start
set clipboard=unnamed
set hidden
set hlsearch

"Specific for Python because vim does not want to use tabs for Python
autocmd filetype python setlocal noexpandtab tabstop=4 shiftwidth=4

" Vim specific tab options, because I do want to have tabs in my .vimrc
autocmd filetype vim setlocal expandtab tabstop=4 shiftwidth=4


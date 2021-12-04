" This file is used for code style options
" It is turned on from main vimrc: source ~/.vim/.code_style.vim
" To enable it:
" ln -s <absolute path to this directory>/.default_code_style.vim <absolute path to home directory>/.vim/.code_style.vim

set noexpandtab " global for all types of file
set shiftwidth=4
set softtabstop=4
set tabstop=4

"Specific for Python because vim does not want to use tabs for Python
autocmd filetype python setlocal noexpandtab tabstop=4 shiftwidth=4

" Vim specific tab options, because I do want to have tabs in my .vimrc
autocmd filetype vim setlocal expandtab tabstop=4 shiftwidth=4

"Specific for JS because vim does not want to use tabs for Python
autocmd filetype javascript setlocal noexpandtab tabstop=4 shiftwidth=4

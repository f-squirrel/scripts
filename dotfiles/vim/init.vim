set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
if !exists('g:vscode')
    set termguicolors
    source ~/.vimrc
    " Fixes https://github.com/equalsraf/neovim-qt/issues/686
    " TODO: consider moving to .vimrc
endif

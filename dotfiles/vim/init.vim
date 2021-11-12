set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
if !exists('g:vscode')
    source ~/.vimrc
    " Fixes https://github.com/equalsraf/neovim-qt/issues/686
    " TODO: consider moving to .vimrc
    set termguicolors
endif

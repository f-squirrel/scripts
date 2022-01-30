syntax enable
set mouse=a " Enable mouse
set smartcase " Smartcase search
set number " Display line numbers
set hidden
set ignorecase " Mostly for wildmenu completion
set smartindent
set cindent
set clipboard+=unnamedplus " to be able to copy-paste from other applications without + and * registers

" NVIM defaults start
set autoindent
set backspace=indent,eol,start
set encoding=utf8
set hlsearch " highlight search
set incsearch " Search while typing
set nocompatible              " Non-compatible with vi
" NVIM defaults end

" NVIM default changed
set noautoread " Vim asks if user wants to reload a changed file

let mapleader=","

" Disable Vim-recording
map q <Nop>

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank {higroup="IncSearch", timeout=100}
augroup END

" Colorscheme
set background=dark
colorscheme default

"Highlight current line
set cursorline
highlight ColorColumn ctermbg=darkgray
"highlight CursorLine cterm=NONE gui=NONE ctermbg=darkgrey

"Highligt max line length
set colorcolumn=120

set listchars+=eol:$,tab:>-,space:·
" Navigation
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-h> :bprev<CR>
nnoremap <C-l> :bnext<CR>

" Search
vnoremap // y/<C-R>"<CR>
nnoremap <esc><esc> :nohlsearch<return>

syntax enable
filetype plugin indent on
set mouse=a " Enable mouse
set smartcase " Smartcase search
set number " Display line numbers
set ignorecase " Mostly for wildmenu completion
set smartindent
set cindent
set clipboard+=unnamedplus " to be able to copy-paste from other applications without + and * registers

" NVIM defaults start
set autoindent
set backspace=indent,eol,start
set belloff=all
set cscopeverbose
if has("nvim")
    set display=lastline,msgsep
else
    set display=lastline
endif
set encoding=utf8
set formatoptions=tcqj
set hidden
set history=10000 " max value
set hlsearch " highlight search
set incsearch " Search while typing
if has("nvim")
    set nolangremap
else
    set langnoremap
endif
set laststatus=2
set nocompatible              " Non-compatible with vi
set nojoinspaces
set nostartofline
set nrformats=bin,hex
set ruler
set showcmd
set sidescroll=1
set smarttab
set tabpagemax=50 " max value
set ttyfast
set wildmenu
set wildmode=full
if exists("+wildoptions")
    if has("nvim")
        set wildoptions=pum,tagfile
    else
        set wildoptions=tagfile
    endif
endif

nnoremap Y y$
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>
" NVIM defaults end

" NVIM default changed start
set noautoread " Vim asks if user wants to reload a changed file

try
    " NVIM versions before 0.6.0 do not have this mapping
    unmap <C-L>
catch /.*/
endtry

" NVIM default changed end

let mapleader=","

if has("nvim")
    " Unfortunately, TextYankPost is available in Neovim
    augroup highlight_yank
        autocmd!
        autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank {higroup="IncSearch", timeout=100}
    augroup END
endif

" Colorscheme
set background=dark
colorscheme default

"Highlight current line
set cursorline
highlight ColorColumn ctermbg=darkgray guibg=darkgrey
"highlight CursorLine cterm=NONE gui=NONE ctermbg=darkgrey

"Highligt max line length
set colorcolumn=120

set listchars+=eol:$,tab:>-,space:·

" Key maps
" Disable Vim-recording
map q <Nop>

" Navigation
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-h> :bprev<CR>
nnoremap <C-l> :bnext<CR>

" Search
vnoremap // y/<C-R>"<CR>
nnoremap <esc><esc> :nohlsearch<return>


" Minimal tab-space setup
set expandtab " to insert spaces instead of tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4


"execute pathogen#infect()
"let g:nerdtree_tabs_open_on_console_startup=1

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    " alternatively, pass a path where Vundle should install plugins
    "call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'

    " The following are examples of different formats supported.
    " Keep Plugin commands between vundle#begin/end.
    " plugin on GitHub repo
    Plugin 'tpope/vim-fugitive'
    " plugin from http://vim-scripts.org/vim/scripts.html
    Plugin 'L9'
    " Git plugin not hosted on GitHub
    Plugin 'git://git.wincent.com/command-t.git'
    " git repos on your local machine (i.e. when working on your own plugin)
    "Plugin 'file:///home/gmarik/path/to/plugin'
    " The sparkup vim script is in a subdirectory of this repo called vim.
    " Pass the path to set the runtimepath properly.
    Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
    " Avoid a name conflict with L9
    "Plugin 'user/L9', {'name': 'newL9'}
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'scrooloose/nerdtree'
    Plugin 'rdnetto/YCM-Generator'
    Plugin 'octol/vim-cpp-enhanced-highlight'

    " Track the engine.
    Plugin 'SirVer/ultisnips'
    " Snippets are separated from the engine. Add this if you want them:
    Plugin 'honza/vim-snippets'

    "Plugin 'bbchung/clighter'
    " All of your Plugins must be added before the following line
    call vundle#end()            " required
    filetype plugin indent on    " required
    " To ignore plugin indent changes, instead use:
    "filetype plugin on
    "
    " Brief help
    " :PluginList       - lists configured plugins
    " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
    " :PluginSearch foo - searches for foo; append `!` to refresh local cache
    " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
    "
    " see :h vundle for more details or wiki for FAQ
    " Put your non-Plugin stuff after this line


syntax on
"filetype plugin indent on
set number
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set incsearch
set softtabstop=4
set autoindent
set ignorecase
set smartcase
set cindent
set backspace=indent,eol,start
set clipboard=unnamed

highlight ColorColumn ctermbg=darkgray

"NERDTree config
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$', '\.DS_Store']
set modifiable "to have possibility to add/remove files from NERD Tree menu


"For YcmComplete
let os = substitute(system('uname'), "\n", "", "")
if os == "Darwin"
    let s:clang_library_path='/Library/Developer/CommandLineTools/usr/lib'
    if isdirectory(s:clang_library_path)
        let g:clang_library_path=s:clang_library_path
    endif
elseif os == "Linux"
    " Do Linux-specific stuff.
    " ...
endif
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_use_ultisnips_completer = 1

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
"let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-b>"
"let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
"let g:UltiSnipsEditSplit="vertical"


"for Clighter
"let g:clighter_autostart = 1
"let g:clighter_libclang_file = '/Library/Developer/CommandLineTools/usr/lib/libclang.dylib'
set pastetoggle=<F2>

"Highligt max line length
set colorcolumn=144

"Mappings
map <C-G> :YcmCompleter GoToDeclaration<CR>
"Delete all trailing spaces
nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR> 

"set t_Co=256

"enable mouse
"set mouse=a

"Mappings for mouse-toggle plugin
"https://github.com/nvie/vim-togglemouse
noremap <F11> :call <SID>ToggleMouse()<CR>
inoremap <F11> <Esc>:call <SID>ToggleMouse()<CR>a



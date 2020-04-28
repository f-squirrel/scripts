set nocompatible              " be iMproved, required
filetype off                  " required

function GetOperatingSystemName()
    return substitute(system('uname'), "\n", "", "")
endfunction

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

if GetOperatingSystemName() == "Linux"
    " If installed using git
    set rtp+=~/.fzf
else
    " If installed using Homebrew
    set rtp+=/usr/local/opt/fzf
endif

call vundle#begin()
    " alternatively, pass a path where Vundle should install plugins
    "call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plugin 'gmarik/Vundle.vim'
    " Gblame and all the stuff
    Plugin 'tpope/vim-fugitive'
    " It shows which lines have been added, modified, or removed.
    Plugin 'airblade/vim-gitgutter'
    " A plugin of NERDTree showing git status flags
    Plugin 'Xuyuanp/nerdtree-git-plugin'
    " plugin from http://vim-scripts.org/vim/scripts.html
    Plugin 'L9'

    Plugin 'git://git.wincent.com/command-t.git'
    Plugin 'scrooloose/nerdtree'

    " Check if it works woth Vundle
    Plugin 'crusoexia/vim-monokai'

    Plugin 'Valloric/YouCompleteMe'
    Plugin 'octol/vim-cpp-enhanced-highlight'

    " Track the engine. removed since it is incompatible with neovim on macos
    " Plugin 'SirVer/ultisnips'
    " Snippets are separated from the engine. Add this if you want them:
    " Plugin 'f-squirrel/vim-snippets'
    Plugin 'honza/vim-snippets'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'junegunn/vim-easy-align'

    " Insert or delete brackets, parens, quotes in pair.
    Plugin 'jiangmiao/auto-pairs.git'

    " :StripWhitespace to delete trailing white spaces
    Plugin 'ntpeters/vim-better-whitespace'
    " :Bufonly to delete all buffers but this
    Bundle 'schickling/vim-bufonly'
    " :SyntasticCheck to run syntax check for scripting languages(python)
    Plugin 'vim-syntastic/syntastic'
    " Comment short cuts
    " [count]<leader>c<space> |NERDCommenterToggle|
    " Toggles the comment state of the selected line(s).
    " If the topmost selected line is commented, all selected lines are uncommented and vice versa.
    Plugin 'scrooloose/nerdcommenter'
    " Select and compare lines in code
    Plugin 'AndrewRadev/linediff.vim'
    " ,be to see the list of open buffers
    Plugin 'jlanzarotta/bufexplorer'
    " Shows indention level
    Plugin 'Yggdroot/indentLine'
    Plugin 'rhysd/vim-clang-format'
    "Plugin 'MattesGroeger/vim-bookmarks'
    Plugin 'junegunn/fzf.vim'
    Plugin 'ekalinin/Dockerfile.vim'
    " Neovim-Qt runtime
    Plugin 'equalsraf/neovim-gui-shim'
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

" This file is usually symbolic link to file with code style relevant for
" current company
source ~/.vim/.code_style.vim

set shell=/bin/bash
let mapleader=","
set listchars+=eol:$,tab:>-,space:·

function SetClipboardSettings()
    set clipboard=unnamed " to be able to copy-paste from other applications
    if GetOperatingSystemName() == "Linux"
        set clipboard-=autoselect
    endif
endfunction

function SetColumnGuideLine()
    "Highlight current line
    "set cursorline
    highlight ColorColumn ctermbg=darkgray
    "Highligt max line length
    set colorcolumn=120
endfunction

function SetColorScheme()
    syntax enable
    set background=dark
    colorscheme monokai
    if GetOperatingSystemName() == "Linux"
        let g:rehash256 = 1
    endif
endfunction

function SetNerdTree()
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    " close vim in case only open window is NerdTree
    "autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    let g:NERDTreeShowHidden=1
    let g:NERDTreeIgnore = ['\.pyc$', '\.DS_Store', '\.swp', '\.swn', '\.swo']
    let g:NERDTreeWinPos = "left"
    let g:NERDTreeWinSize=30
    set modifiable "to have possibility to add/remove files from NERD Tree menu

    map <C-n> :NERDTreeToggle<CR>
endfunction

function SetYouCompleteMe()
    "Turns off youCompleteMe
    "let g:loaded_youcompleteme = 1
    let g:ycm_collect_identifiers_from_tags_files=1
    let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
    let g:ycm_key_list_select_completion = ['<C-j>']
    let g:ycm_key_list_previous_completion = ['<C-k>']
    let g:ycm_use_ultisnips_completer = 1
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_use_clangd = 1
    let g:ycm_show_diagnostics_ui = 1
    let g:ycm_autoclose_preview_window_after_completion = 1

    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    "let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger='<C-j>'
    let g:UltiSnipsJumpBackwardTrigger='<C-k>'
    " If you want :UltiSnipsEdit to split your window.
    "let g:UltiSnipsEditSplit="vertical"

    map <C-G>               :YcmCompleter GoTo<CR>
    map <leader>f           :YcmCompleter Format<CR>
    nnoremap <2-LeftMouse>  :YcmCompleter GoTo<CR>
endfunction

function SetCppEnhancedHighlight()
    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_class_decl_highlight = 1
    let g:cpp_posix_standard = 1
    let g:cpp_experimental_simple_template_highlight = 1
    let g:cpp_concepts_highlight = 1
endfunction

set pastetoggle=<F2>

function GetDisplayDimension()
    let dimension = system("~/scripts/terminal-configuration/vim/get_display_dimensions.sh")
    let dimension = split(trim(dimension), 'x')
    let dimension = [ str2nr(dimension[0]), str2nr(dimension[1]) ]
    return dimension
endfunction

function SetVimAirLine()
    set laststatus=2
    se t_Co=256
    let g:airline_theme='dark'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline_powerline_fonts = 1
endfunction

function SetCommandT()
    "Sometimes we deal with really big projects...
    let g:CommandTMaxFiles = 500000
    let g:CommandTSuppressMaxFilesWarning=1
    let g:CommandTMaxCachedDirectories=5
    "Use binary native find to increase speed
    let g:CommandTFileScanner = 'watchman'
    let g:CommandTWildIgnore=&wildignore . ",*.pyc" . ",*.swp" . ",*.swn" . ",*.swo" . ",*.o" . ",*.out"
endfunction

function SetSyntastic()
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 1
    let g:syntastic_python_checkers = ['pyflakes']
    let g:syntastic_python3_checkers = ['pyflakes']
endfunction

function SetEasyAlignMappings()
    nmap ga <Plug>(EasyAlign)
    xmap ga <Plug>(EasyAlign)
endfunction

function SetBufferSwitchingMappings()
    nnoremap <C-Left> :tabprevious<CR>
    nnoremap <C-Right> :tabnext<CR>
    nnoremap <S-Left> :bprev<CR>
    nnoremap <S-Right> :bnext<CR>
    map <C-h> :bprev<CR>
    map <C-l> :bnext<CR>
endfunction

function SetSearchMappings()
    "Select visually text and press // to start search
    vnoremap // y/<C-R>"<CR>
    "Double ESC turns off highlight of search results

    nnoremap <esc><esc> :noh<return>
endfunction

function SetMappingToCloseBufferWithoutClosingWindow()
    map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>.
endfunction

function GrepUnderCursorMapping()
    grep --ignore-case <cword> ./
    cwindow
    redraw!
endfunction

function SetGitGutter()
    autocmd BufWritePost * GitGutter
endfunction

function GrepSensitiveUnderCursorMapping()

    if executable('ag')
        grep --case-sensitive <cword> ./
    else
        grep <cword> ./
    endif
    cwindow
    redraw!
endfunction

function SetupVimClangFormat()
    if filereadable(getcwd() . "/.clang-format")
        let g:clang_format#auto_format = 1
        " map to <Leader>cf in C++ code
        autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
        autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
    else
        let g:clang_format#auto_format = 0
    endif
endfunction

"function SetupVimBookmarks()
"    nmap mo <Plug>BookmarkShowAll
"endfunction

function SetupGrepSettings()
    " The Silver Searcher
    if executable('ag')
        " Use ag over grep
        set grepprg=ag\ --nogroup\ --nocolor\ --numbers
    else
        set grepprg=grep\ --line-number\ --binary-files=without-match\ --recursive\ --exclude=tags\ --exclude-dir=build
    endif
    nnoremap gr :call GrepUnderCursorMapping()<CR>
    nnoremap Gr :call GrepSensitiveUnderCursorMapping()<CR>
endfunction

call SetClipboardSettings()
call SetBufferSwitchingMappings()
call SetColorScheme()
call SetColumnGuideLine()
call SetEasyAlignMappings()
call SetNerdTree()
call SetVimAirLine()
call SetYouCompleteMe()
call SetCppEnhancedHighlight()
call SetCommandT()
call SetSearchMappings()
call SetSyntastic()
call SetMappingToCloseBufferWithoutClosingWindow()
call SetGitGutter()
call SetupVimClangFormat()
"call SetupVimBookmarks()
call SetupGrepSettings()

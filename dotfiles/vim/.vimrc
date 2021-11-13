set nocompatible              " be iMproved, required
filetype off                  " required
set mouse=a

function GetOperatingSystemName()
    return substitute(system('uname'), "\n", "", "")
endfunction


if GetOperatingSystemName() == "Linux"
    " If installed using git
    set rtp+=~/.fzf
else
    " If installed using Homebrew
    set rtp+=/usr/local/opt/fzf
endif

call plug#begin('~/.vim/plugged')

    " plugin from http://vim-scripts.org/vim/scripts.html
    " Gblame and all the stuff
    Plug 'tpope/vim-fugitive'
    " It shows which lines have been added, modified, or removed.
    Plug 'airblade/vim-gitgutter'
    " A plugin of NERDTree showing git status flags
    Plug 'Xuyuanp/nerdtree-git-plugin'
    Plug 'scrooloose/nerdtree'
    Plug 'crusoexia/vim-monokai'

    " for some reasons post install does not work when started here
    Plug 'ycm-core/YouCompleteMe'
    Plug 'octol/vim-cpp-enhanced-highlight'

    " Track the engine. removed since it is incompatible with neovim on macos
    Plug 'SirVer/ultisnips'
    " Snippets are separated from the engine. Add this if you want them:
    " Plugin 'f-squirrel/vim-snippets'
    Plug 'honza/vim-snippets'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'junegunn/vim-easy-align'

    " Insert or delete brackets, parens, quotes in pair.
    Plug 'jiangmiao/auto-pairs'

    " :StripWhitespace to delete trailing white spaces
    Plug 'ntpeters/vim-better-whitespace'
    " :Bufonly to delete all buffers but this
    Plug 'schickling/vim-bufonly'
    " :SyntasticCheck to run syntax check for scripting languages(python)
    Plug 'vim-syntastic/syntastic'
    " Comment short cuts
    " <Leader>cl
    " [count]<leader>c<space> |NERDCommenterToggle|
    " Toggles the comment state of the selected line(s).
    " If the topmost selected line is commented, all selected lines are uncommented and vice versa.
    Plug 'scrooloose/nerdcommenter'
    " Select and compare lines in code
    Plug 'AndrewRadev/linediff.vim'
    " ,be to see the list of open buffers
    Plug 'jlanzarotta/bufexplorer'
    " Shows indention level
    Plug 'Yggdroot/indentLine'
    Plug 'rhysd/vim-clang-format'
    "Plugin 'MattesGroeger/vim-bookmarks'
    Plug 'junegunn/fzf.vim'
    Plug 'ekalinin/Dockerfile.vim'
    " :CopyPath and :CopyFileName
    Plug 'taku-o/vim-copypath'
    " Markdown viewer
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'cespare/vim-toml'
    " Neovim-Qt runtime
    if has('nvim')
        Plug 'equalsraf/neovim-gui-shim'
    endif
call plug#end()

" This file is usually symbolic link to file with code style relevant for
" current company
source ~/.vim/.code_style.vim

set shell=/bin/bash
let mapleader=","
set listchars+=eol:$,tab:>-,space:·

    set clipboard=unnamedplus " to be able to copy-paste from other applications
function SetClipboardSettings()
    set clipboard=unnamed " to be able to copy-paste from other applications
    if GetOperatingSystemName() == "Linux"
        set clipboard-=autoselect
    endif
endfunction

function SetColumnGuideLine()
    "Highlight current line
    set cursorline
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
    nnoremap <leader>g      :YcmCompleter GoTo<CR>
    map <leader>f           :YcmCompleter Format<CR>
    nnoremap <2-LeftMouse>  :YcmCompleter GoTo<CR>
    nnoremap yr             :YcmCompleter GoToReferences<CR>
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

function SetSyntastic()
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 1
    let g:syntastic_python_checkers = ['pyflakes']
    let g:syntastic_python_python_exec = 'python3'
endfunction

function SetEasyAlignMappings()
    nmap ga <Plug>(EasyAlign)
    xmap ga <Plug>(EasyAlign)
endfunction

function SetBufferSwitchingMappings()
    nnoremap <C-Left> :tabprevious<CR>
    nnoremap <C-Right> :tabnext<CR>
    nnoremap <C-h> :bprev<CR>
    nnoremap <C-l> :bnext<CR>
endfunction

function SetSearchMappings()
    "Select visually text and press // to start search
    vnoremap // y/<C-R>"<CR>
    nnoremap <esc><esc> :nohlsearch<return>
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
    set grepprg=grep\ --line-number\ --binary-files=without-match\ --recursive\ --exclude=tags\ --exclude-dir=build
    nnoremap gr :call GrepUnderCursorMapping()<CR>
    nnoremap Gr :call GrepSensitiveUnderCursorMapping()<CR>
endfunction

function SetupFzf()
    map <leader>ff          :Files<CR>
    map <leader>ft          :Rg<CR>
    map <leader>fs          :BLines<CR>

    " Rg: to search in content, not filenames
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
endfunction

function SetupTerminal()
    tnoremap <Esc> <C-\><C-n>
    set termguicolors
endfunction

function SetupVimFugitive()
    set diffopt+=vertical
endfunction

"call SetClipboardSettings()
call SetBufferSwitchingMappings()
call SetColorScheme()
call SetColumnGuideLine()
call SetEasyAlignMappings()
call SetNerdTree()
call SetVimAirLine()
call SetYouCompleteMe()
call SetCppEnhancedHighlight()
call SetSearchMappings()
call SetSyntastic()
call SetMappingToCloseBufferWithoutClosingWindow()
call SetGitGutter()
call SetupVimClangFormat()
"call SetupVimBookmarks()
call SetupGrepSettings()
call SetupFzf()
call SetupTerminal()
call SetupVimFugitive()

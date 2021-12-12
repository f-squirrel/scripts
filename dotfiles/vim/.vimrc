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

set shell=zsh
let mapleader=","
set listchars+=eol:$,tab:>-,space:·

" Disable Vim-recording
map q <Nop>

" This file is usually symbolic link to file with code style relevant for
" current company
source ~/.vim/.code_style.vim

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

    " Gblame and all the stuff
    Plug 'tpope/vim-fugitive'
    " It shows which lines have been added, modified, or removed.
    Plug 'airblade/vim-gitgutter'
    " Colors devicons
    "Plug 'crusoexia/vim-monokai'

    Plug 'kyazdani42/nvim-web-devicons' " for file icons
    Plug 'kyazdani42/nvim-tree.lua' " file tree
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " cool syntax highlight
    Plug 'tanvirtin/monokai.nvim'

    " for some reasons post install does not work when started here
    Plug 'ycm-core/YouCompleteMe'

    " Track the engine. removed since it is incompatible with neovim on macos
    Plug 'SirVer/ultisnips'
    " Snippets are separated from the engine. Add this if you want them:
    " Plugin 'f-squirrel/vim-snippets'
    Plug 'honza/vim-snippets'

    " Easily align lines
    Plug 'junegunn/vim-easy-align'

    " Status line
    Plug 'nvim-lualine/lualine.nvim'

    " Buffers
    Plug 'akinsho/bufferline.nvim'

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
    Plug 'lukas-reineke/indent-blankline.nvim'

    Plug 'junegunn/fzf.vim'
    Plug 'ekalinin/Dockerfile.vim'

    " :CopyPath and :CopyFileName
    Plug 'f-squirrel/copypath.vim'

    " Markdown viewer
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

    Plug 'cespare/vim-toml'

    " Used :BD to kill the last buffer and prevent NERDTree from expanding
    Plug 'qpkorr/vim-bufkill'

    " Neovim-Qt runtime
    if has('nvim')
        Plug 'equalsraf/neovim-gui-shim'
    endif
call plug#end()

function SetColumnGuideLine()
    "Highlight current line
    set cursorline
    highlight ColorColumn ctermbg=darkgray
    "Highligt max line length
    set colorcolumn=120
endfunction

function SetColorScheme()
    set background=dark
    colorscheme monokai_pro
endfunction

function SetYouCompleteMe()
    "Turns off youCompleteMe
    "let g:loaded_youcompleteme = 1
    let g:ycm_collect_identifiers_from_tags_files=1
    let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
    let g:ycm_key_list_select_completion = ['<C-j>']
    let g:ycm_key_list_previous_completion = ['<C-k>']
    let g:ycm_use_ultisnips_completer = 1
    let g:ycm_use_clangd = 1
    let g:ycm_show_diagnostics_ui = 1
    let g:ycm_autoclose_preview_window_after_completion = 1

    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    "let g:UltiSnipsExpandTrigger="<tab>"
    let g:UltiSnipsJumpForwardTrigger='<C-j>'
    let g:UltiSnipsJumpBackwardTrigger='<C-k>'
    " If you want :UltiSnipsEdit to split your window.
    "let g:UltiSnipsEditSplit="vertical"

    nnoremap  <C-G>               :YcmCompleter GoTo<CR>
    nnoremap <leader>g      :YcmCompleter GoTo<CR>
    nnoremap <2-LeftMouse>  :YcmCompleter GoTo<CR>
    nnoremap gd              :YcmCompleter GoTo<CR>
    nnoremap gD              :YcmCompleter GoToDeclaration<CR>
    nnoremap <leader>f       :YcmCompleter Format<CR>
    nnoremap yr             :YcmCompleter GoToReferences<CR>
endfunction

function GetDisplayDimension()
    let dimension = system("~/scripts/terminal-configuration/vim/get_display_dimensions.sh")
    let dimension = split(trim(dimension), 'x')
    let dimension = [ str2nr(dimension[0]), str2nr(dimension[1]) ]
    return dimension
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
    nnoremap ga <Plug>(EasyAlign)
    xnoremap ga <Plug>(EasyAlign)
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
    " To show git status fast
    set updatetime=200
    autocmd BufWritePost * GitGutter
endfunction

function GrepSensitiveUnderCursorMapping()
    grep <cword> ./
    endif
    cwindow
    redraw!
endfunction

function SetupGrepSettings()
    set grepprg=grep\ --line-number\ --binary-files=without-match\ --recursive\ --exclude=tags\ --exclude-dir=build
    nnoremap gr :call GrepUnderCursorMapping()<CR>
    nnoremap Gr :call GrepSensitiveUnderCursorMapping()<CR>
endfunction

function SetupFzf()
    " Search for file in current directory
    nnoremap <leader>ff          :Files<CR>

    " Search for a string in files in current directory
    nnoremap <leader>fg          :Rg<CR>
    nnoremap <leader>ft          :Rg<CR>

    " Search for a string in current buffer
    nnoremap <leader>fs          :BLines<CR>
    nnoremap <leader>fl          :BLines<CR>

    " Search in command history
    nnoremap <leader>fh          :History:<CR>

    " Rg: to search in content, not filenames
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)
endfunction

function SetupVimFugitive()
    set diffopt+=vertical
endfunction

function SetupCopyPath()
    let g:copypath_copy_to_unnamed_plus_register = 1
endfunction

function SetupIndentPlug()
    " Uncomment to disable the plugin
    "let g:indent_blankline_enabled = v:false
    let g:indent_blankline_show_first_indent_level = v:false
endfunction

function SetupNvimTree()
    highlight NvimTreeFolderIcon guifg=grey
    nnoremap <C-n>              :NvimTreeToggle<CR>
    nnoremap <C-r>              :NvimTreeRefresh<CR>
    nnoremap <leader>n          :NvimTreeFindFile<CR>
endfunction

call SetBufferSwitchingMappings()
call SetColorScheme()
call SetColumnGuideLine()
call SetEasyAlignMappings()
call SetYouCompleteMe()
call SetSearchMappings()
call SetSyntastic()
call SetMappingToCloseBufferWithoutClosingWindow()
call SetGitGutter()
call SetupGrepSettings()
call SetupFzf()
call SetupVimFugitive()
call SetupCopyPath()
call SetupIndentPlug()
call SetupNvimTree()

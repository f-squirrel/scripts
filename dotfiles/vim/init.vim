"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath

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

call plug#begin()

    " Gblame and all the stuff
    Plug 'tpope/vim-fugitive'
    " It shows which lines have been added, modified, or removed.
    "Plug 'airblade/vim-gitgutter'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'lewis6991/gitsigns.nvim'
    " Colors devicons
    "Plug 'crusoexia/vim-monokai'

    Plug 'kyazdani42/nvim-web-devicons' " for file icons
    Plug 'kyazdani42/nvim-tree.lua' " file tree
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " cool syntax highlight
    Plug 'f-squirrel/monokai.nvim'

    " for some reasons post install does not work when started here
    "Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clang-completer --rust-completer' }

    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    "Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    "Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'williamboman/nvim-lsp-installer'

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
    "Plug 'vim-syntastic/syntastic'

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

    " Plugin outside ~/.vim/plugged with post-update hook
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    "Plug 'junegunn/fzf.vim'

    Plug 'nvim-telescope/telescope.nvim'
    Plug 'ekalinin/Dockerfile.vim'

    " :CopyPath and :CopyFileName
    Plug 'f-squirrel/copypath.vim'

    " Markdown viewer
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

    Plug 'cespare/vim-toml'

    " Used :BD to kill the last buffer and prevent NERDTree from expanding
    Plug 'qpkorr/vim-bufkill'

    Plug 'sainnhe/sonokai'
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

    "let g:sonokai_style = 'espresso'
    "let g:sonokai_enable_italic = 1
    "let g:sonokai_menu_selection_background = 'yellow'
    "let g:sonokai_diagnostic_text_highlight = 1
    "let g:sonokai_diagnostic_line_highlight = 1
    "colorscheme sonokai
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

"function SetSyntastic()
"    set statusline+=%#warningmsg#
"    set statusline+=%{SyntasticStatuslineFlag()}
"    set statusline+=%*
"
"    let g:syntastic_always_populate_loc_list = 1
"    let g:syntastic_auto_loc_list = 1
"    let g:syntastic_check_on_open = 1
"    let g:syntastic_check_on_wq = 1
"    let g:syntastic_python_checkers = ['pyflakes']
"    let g:syntastic_python_python_exec = 'python3'
"endfunction

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

"function SetMappingToCloseBufferWithoutClosingWindow()
"    map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>.
"endfunction

function GrepUnderCursorMapping()
    grep --ignore-case <cword> ./
    cwindow
    redraw!
endfunction

"function SetGitGutter()
"    " To show git status fast
"    set updatetime=200
"    autocmd BufWritePost * GitGutter
"endfunction

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

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>gr <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>fl <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').command_history()<cr>


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
    nnoremap <leader>n          :NvimTreeFindFile<CR>
endfunction

call SetBufferSwitchingMappings()
call SetColorScheme()
call SetColumnGuideLine()
call SetEasyAlignMappings()
"call SetYouCompleteMe()
call SetSearchMappings()
"call SetSyntastic()
"call SetMappingToCloseBufferWithoutClosingWindow()
"call SetGitGutter()
"call SetupGrepSettings()
"call SetupFzf()
call SetupVimFugitive()
call SetupCopyPath()
call SetupIndentPlug()
call SetupNvimTree()

"highlight NvimTreeFolderIcon guibg=blue
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {
  open_on_setup       = true,
  update_focused_file = {
     enable      = true,
   },
  view = {
     auto_resize = true,
   },
}

require'lualine'.setup {
  options = {
     theme = 'powerline'
   }
}

require('bufferline').setup {
  options = {
    offsets = {filetype = "NvimTree", text = "File Explorer", text_align = "left"},
    separator_style = "plant"
  },
}

require('gitsigns').setup()


-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)


local lspconfig = require('lspconfig')
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
  buf_set_keymap('n', '<2-LeftMouse>', "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
  buf_set_keymap('n', '<leader>K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- Original code actions
  -- buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', "<cmd>lua require('telescope.builtin').lsp_code_actions()<CR>", opts)
  -- Original references
  -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', 'gr', "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
--local servers = { 'clangd', 'cmake', 'rust_analyzer', 'pyright', 'tsserver' }
--for _, lsp in ipairs(servers) do
--  lspconfig[lsp].setup {
--    on_attach = on_attach,
--    capabilities = capabilities,
--  }
--end

-- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,noselect'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
  mapping = {
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
    -- Leads to error messages
    --  elseif luasnip.expand_or_jumpable() then
    --    luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
    -- Leads to error messages
    --  elseif luasnip.jumpable(-1) then
    --    luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'ultisnips' },
  },
}

-- Include the servers you want to have installed by default below
 local lsp_installer = require("nvim-lsp-installer")

-- Include the servers you want to have installed by default below
local servers = {
    "clangd",
    "cmake",
    "grammarly",
    "pylsp",
    "pyright",
    "rust_analyzer",
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found then
    if not server:is_installed() then
      print("Installing " .. name)
      server:install()
    end
  end
end

 -- Register a handler that will be called for all installed servers.
 -- Alternatively, you may also register handlers on specific server instances instead (see example below).
 lsp_installer.on_server_ready(function(server)
     local opts = {}

     -- (optional) Customize the options passed to the server
     -- if server.name == "tsserver" then
     --     opts.root_dir = function() ... end
     -- end

     -- This setup() function is exactly the same as lspconfig's setup function.
     -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
     server:setup {
        opts = opts,
        on_attach = on_attach,
        capabilities = capabilities,
         }
 end)
EOF

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
    Plug 'nvim-lua/plenary.nvim'
    Plug 'lewis6991/gitsigns.nvim'

    Plug 'kyazdani42/nvim-web-devicons' " for file icons
    Plug 'kyazdani42/nvim-tree.lua' " file tree

    Plug 'f-squirrel/monokai.nvim'
    Plug 'navarasu/onedark.nvim'

    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " cool syntax highlight

    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/cmp-nvim-lsp'
    "Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    "Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'
    Plug 'williamboman/nvim-lsp-installer'

    Plug 'SirVer/ultisnips'
    " Snippets are separated from the engine. Add this if you want them:
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

    " Comment short cuts
    " <Leader>cl
    " [count]<leader>c<space> |NERDCommenterToggle|
    " Toggles the comment state of the selected line(s).
    " If the topmost selected line is commented, all selected lines are uncommented and vice versa.
    Plug 'scrooloose/nerdcommenter'

    " Select and compare lines in code
    Plug 'AndrewRadev/linediff.vim'

    " ,be to see the list of open buffers
    "Plug 'jlanzarotta/bufexplorer'

    " Shows indention level
    Plug 'lukas-reineke/indent-blankline.nvim'

    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

    Plug 'nvim-telescope/telescope.nvim'

    " :CopyPath and :CopyFileName
    Plug 'f-squirrel/copypath.vim'

    " Markdown viewer
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

    Plug 'cespare/vim-toml'

    Plug 'sainnhe/sonokai'

    Plug 'nvim-treesitter/playground'
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

function GrepUnderCursorMapping()
    grep --ignore-case <cword> ./
    cwindow
    redraw!
endfunction

function GrepSensitiveUnderCursorMapping()
    grep <cword> ./
    cwindow
    redraw!
endfunction

function SetupTelescopeFind()
    nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
    nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
    nnoremap <leader>gr <cmd>lua require('telescope.builtin').grep_string()<cr>
    nnoremap <leader>fl <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
    nnoremap <leader>fh <cmd>lua require('telescope.builtin').command_history()<cr>
    nnoremap <leader>be <cmd>lua require('telescope.builtin').buffers()<cr>
    nnoremap <leader>q  <cmd>lua require('telescope.builtin').diagnostics( {bufnr=0} )<cr>
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
call SetSearchMappings()
call SetupVimFugitive()
call SetupCopyPath()
call SetupIndentPlug()
call SetupNvimTree()
call SetupTelescopeFind()

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
  vim.lsp.set_log_level('debug')
  -- Mappings.
  local opts = { noremap=true }

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
  -- buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
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

 require('telescope').setup{
    pickers = {
        find_files = {
            hidden = true
        }
    },
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
        mappings = {
          i = {
            ["<esc>"] = require('telescope.actions').close,
            ["<C-j>"] = require('telescope.actions').move_selection_next,
            ["<C-k>"] = require('telescope.actions').move_selection_previous,
            ["<C-d>"] = require('telescope.actions').delete_buffer,
          },
          n = {
            ["<esc>"] = require('telescope.actions').close,
            ["<C-j>"] = require('telescope.actions').move_selection_next,
            ["<C-k>"] = require('telescope.actions').move_selection_previous,
            ["<C-d>"] = require('telescope.actions').delete_buffer,
          },
    }
  },
 }

require "nvim-treesitter.configs".setup {
  playground = {
    enable = true,
    disable = {},
    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
    persist_queries = false, -- Whether the query persists across vim sessions
    keybindings = {
      toggle_query_editor = 'o',
      toggle_hl_groups = 'i',
      toggle_injected_languages = 't',
      toggle_anonymous_nodes = 'a',
      toggle_language_display = 'I',
      focus_language = 'f',
      unfocus_language = 'F',
      update = 'R',
      goto_node = '<cr>',
      show_help = '?',
    },
  }
}
EOF

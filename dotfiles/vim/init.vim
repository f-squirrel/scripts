" Initial settings
source ~/scripts/dotfiles/vim/minimal.vim

if exists('g:vscode')
    " VSCode extension
    "
    nnoremap <leader>gb <Cmd>call VSCodeNotify('gitlens.toggleFileBlame')<cr>
    finish
endif

" This file is usually symbolic link to file with code style relevant for
" current company
source ~/.vim/.code_style.vim

" Either exits or not
set runtimepath+=${HOME}/neovim-qt/src/gui/runtime

let g:plug_timeout = 120
let g:plug_retries = 5

call plug#begin()
"
    " Gblame and all the stuff
    Plug 'tpope/vim-fugitive'

    " Git status on the left side
    Plug 'lewis6991/gitsigns.nvim'

    " Neovim tools library, used by other plugins
    Plug 'nvim-lua/plenary.nvim'

    " File icons
    Plug 'kyazdani42/nvim-web-devicons'

    " File tree
    Plug 'kyazdani42/nvim-tree.lua'

    " Monokai color scheme
    Plug 'f-squirrel/monokai.nvim'
    Plug 'navarasu/onedark.nvim'
    Plug 'sainnhe/sonokai'

    " Tree-sitter syntax highlight
    "Plug 'nvim-treesitter/nvim-treesitter'
    Plug 'nvim-treesitter/nvim-treesitter' "", {'do': ':TSUpdate'}

    " Plugin for debugging Tree-sitter
    Plug 'nvim-treesitter/playground'

    " Smart config for Neovim LSP
    Plug 'neovim/nvim-lspconfig'

    " Autocomplete trigger for Neovim LSP
    Plug 'hrsh7th/cmp-nvim-lsp'
    "Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    "Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/nvim-cmp'

    " Integration between LSP and Ultisnips
    Plug 'quangnguyen30192/cmp-nvim-ultisnips'

    " Simple installation for LSP servers
    Plug 'williamboman/nvim-lsp-installer'

    " Signature help for methods/functions
    Plug 'ray-x/lsp_signature.nvim'

    " Snippets
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
    "Plug 'jiangmiao/auto-pairs'
    Plug 'windwp/nvim-autopairs'

    " :StripWhitespace to delete trailing white spaces
    Plug 'ntpeters/vim-better-whitespace'

    " :Bufonly to delete all buffers but this
    Plug 'schickling/vim-bufonly'

    " Comment short cuts
    " <Leader>cl
    " [count]<leader>c<space> |NERDCommenterToggle|
    " Toggles the comment state of the selected line(s).
    " If the topmost selected line is commented, all selected lines are uncommented and vice versa.
    Plug 'preservim/nerdcommenter'

    " Select and compare lines in code
    Plug 'AndrewRadev/linediff.vim'

    " ,be to see the list of open buffers
    "Plug 'jlanzarotta/bufexplorer'

    " Shows indention level
    Plug 'lukas-reineke/indent-blankline.nvim'

    " Install FZF via Neovim (not sure if it is a good idea because Neovim
    " does not use it anymore)
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

    " Smart lists and many more
    Plug 'nvim-telescope/telescope.nvim'

    " :CopyPath and :CopyFileName
    Plug 'f-squirrel/copypath.vim'

    " Markdown viewer
    "Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

    " Highlight all occurances of current word
    "Plug 'RRethy/vim-illuminate'
call plug#end()

function SetColorScheme()
    set background=dark
    " The settings shall be done here, otherwise thery are overriden by other
    " components. Why? No idea
lua <<EOF
    local monokai = require('monokai')
    local palette = monokai.pro
    palette.white = '#dbd0d2'
    palette.cursor_line = '#363a45'
    -- To revert the color uncomment the line below
    --palette.cursor_line = palette.base3
    monokai.setup {
        palette = palette,
        custom_hlgroups = {
            Function = {
                fg = palette.green,
                --style = 'none'
            },
            Whitespace = {
                fg = palette.base5,
            },
            TSFunction = {
                fg = palette.green,
                --style = 'none'
            },
            CursorLine = {
                bg = palette.cursor_line,
            },
        }
    }
EOF
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
    nnoremap <leader>gb :Git blame<cr>
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

function SetupGitsigns()
    nnoremap ]c :Gitsigns next_hunk<CR>
    nnoremap [c :Gitsigns next_hunk<CR>
endfunction

call SetBufferSwitchingMappings()
call SetColorScheme()
call SetEasyAlignMappings()
call SetSearchMappings()
call SetupVimFugitive()
call SetupCopyPath()
call SetupIndentPlug()
call SetupNvimTree()
call SetupTelescopeFind()
call SetupGitsigns()

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
  open_on_setup       = false, -- Do not launch automatically because then [Noname] buffer stays
  update_focused_file = {
     enable      = true,
   },
  view = {
     auto_resize = true,
   },
}

require'lualine'.setup {
  options = {
     theme = 'codedark',
     component_separators = { left = '', right = ''},
     section_separators = { left = '', right = ''},
   }
}

require('bufferline').setup {
  options = {
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
  vim.lsp.set_log_level('info')
  -- Mappings.
  local opts = { noremap=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gd', "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
  buf_set_keymap('n', '<2-LeftMouse>', "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
  buf_set_keymap('n', '<leader>K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
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

  require "lsp_signature".on_attach()
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
    ['<C-n>'] = cmp.mapping.complete(),
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
    --"pyright",
    "jedi_language_server",
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

require('telescope').setup {
    pickers = {
        find_files = {
            hidden = true
        }
    },
    defaults = {
    -- Default configuration for telescope goes here:

        layout_strategy = 'vertical',
        layout_config = {
            vertical = { width = 0.95 }
            -- other layout configuration here
        },
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

require('nvim-autopairs').setup{}
EOF

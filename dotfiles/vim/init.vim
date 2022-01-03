set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
if !exists('g:vscode')
    set termguicolors
    source ~/.vimrc
    " Fixes https://github.com/equalsraf/neovim-qt/issues/686
    " TODO: consider moving to .vimrc
endif

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
EOF

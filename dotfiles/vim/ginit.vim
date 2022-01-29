" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

function GuiIncreaseFont()
    let l:splitted=split(g:GuiFont, "h")
    let l:font_num=str2nr(l:splitted[1]) + 1
    let l:new_font=l:splitted[0] . "h" . font_num
    execute 'Guifont' l:new_font
endfunction

function GuiDecreaseFont()
    let l:splitted=split(g:GuiFont, "h")
    let l:font_num=str2nr(l:splitted[1]) - 1
    let l:new_font=l:splitted[0] . "h" . font_num
    execute 'Guifont' l:new_font
endfunction

function GuiSetDefaultFont()
    execute 'Guifont' g:DefaultFont
endfunction

"This is a good feature but unfortunately it is not good for the YCM
"Need to check from time to time if it works
"Guifont Source\ Code\ Pro\ for\ Powerline:h16
" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    let g:DefaultFont="JetBrains Mono:h10"
    call GuiSetDefaultFont()
    execute 'Guifont' g:DefaultFont
    "Guifont FiraCode\ Nerd\ Font:h12
endif

" Disable GUI ScrollBar
if exists(':GuiScrollBar')
    GuiScrollBar 0
endif

" Meanwhile does not work, TODO(Debug)
if exists(':GuiRenderLigatures')
    GuiRenderLigatures 1
endif
"colorscheme monokai_pro

"Allows to yank in local clipboard(even from remote!)
if exists('*GuiClipboard')
    call GuiClipboard()
endif

if exists('*GuiWindowFrameless')
    call GuiWindowFrameless(1)
endif

if exists('*GuiWindowMaximized')
    call GuiWindowMaximized(1)
endif

nnoremap <silent> <C-=> :call GuiIncreaseFont()<CR>
nnoremap <silent> <C--> :call GuiDecreaseFont()<CR>
nnoremap <silent> <C-0> :call GuiSetDefaultFont()<CR>

nnoremap  <F11> :call GuiWindowFullScreen(!g:GuiWindowFullScreen)<CR>
" Enable Mouse
set mouse=a

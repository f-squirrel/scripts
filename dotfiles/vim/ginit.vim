" Disable GUI Tabline
if exists(':GuiTabline')
    GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
    GuiPopupmenu 0
endif

"This is a good feature but unfortunately it is not good for the YCM
"Need to check from time to time if it works
"Guifont Source\ Code\ Pro\ for\ Powerline:h16
" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    Guifont JetBrains Mono:h12
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

let g:gui_full_screen=0
function GuiToggleFullScreen()
    if g:gui_full_screen == 0
        call GuiWindowFullScreen(1)
        let g:gui_full_screen=1
    else
        call GuiWindowFullScreen(0)
        let g:gui_full_screen=0
    endif
endfunction

nnoremap  <F11> :call GuiToggleFullScreen()<CR>
" Enable Mouse
set mouse=a

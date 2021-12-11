"I want to see buffers on top of the screen
GuiTabline 0
GuiPopupmenu 0

"This is a good feature but unfortunately it is not good for the YCM
"Need to check from time to time if it works
"Guifont Source\ Code\ Pro\ for\ Powerline:h16
Guifont FiraCode Nerd\ Font\ Mono:h12
GuiRenderLigatures 1
colorscheme monokai_pro

"Allows to yank in local clipboard(even from remote!)
call GuiClipboard()

" Show current path in window title
set title
augroup dirchange
    autocmd!
    autocmd DirChanged * let &titlestring=v:event['cwd']
augroup END

" Enable Mouse
set mouse=a

function! GetOperatingSystemName()
    return substitute(system('uname'), "\n", "", "")
endfunction

colorscheme monokai
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

function SetClipboardGuiSettings()
        set guioptions-=a
        set guioptions-=A
        set guioptions-=aA
endfunction

if GetOperatingSystemName() == "Linux"
    call SetClipboardGuiSettings()
endif

set guifont=Source\ Code\ Pro\ for\ Powerline:h16

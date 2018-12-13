function! GetOperatingSystemName()
    return substitute(system('uname'), "\n", "", "")
endfunction

if GetOperatingSystemName() == "Linux"
    colorscheme molokai
else
    colorscheme solarized
endif
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

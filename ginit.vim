" Make the GUI full-size.
call GuiWindowMaximized(1)

" Disable the buggy native tabline.
if has('nvim')
    GuiTabline 0
end

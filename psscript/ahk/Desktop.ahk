^+Tab::
toggle := !toggle
if (toggle)
    Send, ^#{Right}  ; Switches to the next virtual desktop in Windows 11.
else
    Send, ^#{Left}  ; Switches to the previous virtual desktop in Windows 11.
return

^d::^!v

F3:: ^[
#IfWinActive ahk_exe EXCEL.EXE

~PgUp up::
toggle := !toggle
if (toggle)
    Send, ^#{Right}  ; Switches to the next virtual desktop in Windows 11.
else
    Send, ^#{Left}  ; Switches to the previous virtual desktop in Windows 11.
return

PgUp::
If !start                      ; If time marker is not set,
 start := A_TickCount          ;  then set it to the current "time", to mark the start of key-down
Send {Blind}{vkE8}             ; Disable Start menu activation while allowing use of LWin as a modifier
Return                         ; See https://www.autohotkey.com/docs/v1/lib/_MenuMaskKey.htm#Remarks



F3::^!v

F4:: ^[

~PgDn up::
If (A_PriorKey = "PgDn"        ; If no keys were pressed after LWin,
 && A_TickCount - start < 300) ;  and key-up occurred shortly after key-down,
        WinGet, proc, ProcessName, A
    WinGet, win, List, ahk_exe %proc%
    Loop, %win%
     uid := win%A_Index%
    WinActivate, ahk_id %uid%
    WinGetTitle, title, A
start := 0                     ; Reset the time marker
Return

PgDn::
If !start                      ; If time marker is not set,
 start := A_TickCount          ;  then set it to the current "time", to mark the start of key-down
Send {Blind}{vkE8}             ; Disable Start menu activation while allowing use of LWin as a modifier
Return                         ; See https://www.autohotkey.com/docs/v1/lib/_MenuMaskKey.htm#Remarks

#IfWinActive
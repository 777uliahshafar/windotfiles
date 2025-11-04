; ************************
; Most common programs
; ************************


RemoveToolTip:
ToolTip
return

;=========================================
; Check whether the target window is activation target
; Alt- tab function for remapping
;=========================================
IsWindow(hWnd){
    WinGet, dwStyle, Style, ahk_id %hWnd%
    if ((dwStyle&0x08000000) || !(dwStyle&0x10000000)) {
        return false
    }
    WinGet, dwExStyle, ExStyle, ahk_id %hWnd%
    if (dwExStyle & 0x00000080) {
        return false
    }
    WinGetClass, szClass, ahk_id %hWnd%
    if (szClass = "TApplication") {
        return false
    }
    return true
}

AltTab(){
    list := ""
    WinGet, id, list
    Loop, %id%
    {
        this_ID := id%A_Index%
        IfWinActive, ahk_id %this_ID%
            continue
        WinGetTitle, title, ahk_id %this_ID%
        If (title = "")
            continue
        If (!IsWindow(WinExist("ahk_id" . this_ID)))
            continue
        WinActivate, ahk_id %this_ID%
        WinWaitActive, ahk_id %this_ID%,,2
            break
    }
}

; =========================================
; Window Arrangement (Windows Terminal, Chrome, Sioyek)
; =========================================

FixedWindow(winTitle,XP, WP) {

	; Get Taskbar height
	WinGetPos,,, tbW, tbH, ahk_class Shell_TrayWnd

	; Calculate new position and size
	XNew := (A_ScreenWidth * XP / 100)
	WNew := (A_ScreenWidth * WP / 100)
	HNew := (A_ScreenHeight - tbH)
	TopNew := 2
	; MsgBox, %XNew% - %WNew% ; DEBUG
	WinRestore, %WinTitle%
	WinMove, %WinTitle%,, %XNew%, %TopNew%, %WNew%, %HNew%
	WinActivate
}

AltWindow(winTitle,XP, WP) {

	; Get Taskbar height
	WinGetPos,,, tbW, tbH, ahk_class Shell_TrayWnd

	; Calculate new position and size
	XNew := (A_ScreenWidth * XP / 100)
	WNew := (A_ScreenWidth * WP / 100)
	HNew := (A_ScreenHeight - tbH)
	TopNew := 2
	; MsgBox, %XNew% - %WNew% ; DEBUG
	WinRestore, %WinTitle%
	WinMove, %WinTitle%,, %XNew%, %TopNew%, %WNew%, %HNew%
}

SwitchWindow(winTitle){
	 If WinExist(winTitle) {
	; MsgBox, %XNew% - %WNew% ; DEBUG
    WinActivate, %winTitle%
    ; WinRestore, %winTitle%
} Else MsgBox 48, Error, % "Window was not found.`n`n" winTitle
}

WhichWindow(winTitle, winProg){
	 If WinExist(winTitle) {
	; MsgBox, %XNew% - %WNew% ; DEBUG
    WinActivate, %winTitle%
} Else Run, %winProg%

}

;=========================================
; RESIZE WINDOW
;=========================================

!+=::
FixedWindow("ahk_exe WindowsTerminal.exe", 0, 62.2222)
FixedWindow("ahk_exe sioyek.exe" , 62.2222, 33.3333)
AltWindow("ahk_exe chrome.exe" , 62.2222, 33.3333)
Return

!-::
FixedWindow("ahk_exe WindowsTerminal.exe", 0, 33.3333)
FixedWindow("ahk_exe sioyek.exe" , 34.4444, 66.66666)
AltWindow("ahk_exe chrome.exe" , 34.4444, 66.66666)
Return

!=::
FixedWindow("ahk_exe WindowsTerminal.exe", 0, 49.9999)
FixedWindow("ahk_exe sioyek.exe" , 49.9999, 49.9999)
AltWindow("ahk_exe chrome.exe" , 49.9999, 49.99999)
Return

;=========================================
; SWITCH BETWEEN WINDOW
;=========================================

!l::
    WhichWindow("ahk_exe chrome.exe", "chrome.exe")
    ToolTip, Zotero(P) Terminal(J) Sioyek(K) Chrome(N), 695, 95
SetTimer, RemoveToolTip, -1500
Return

!k::
KeyWait,k,T0.3 ;wait 0.5 seconds for release key
If (ErrorLevel) ;more than 0.5 sec have passed
{
WinMaximize, "ahk_exe sioyek.exe"
send #{Left}
send !{ESC}
WinMaximize, "ahk_exe sioyek.exe"
send #{Right}
KeyWait,k ;prevent sending n after notepad opened
}
Else
{
    WhichWindow("ahk_exe sioyek.exe", "sioyek.exe")
    ToolTip, Zotero(P) Terminal(J) Sioyek(K) Chrome(N), 695, 95
SetTimer, RemoveToolTip, -1500
}
Return

!h::
    WhichWindow("ahk_exe zotero.exe", "zotero.exe")
    ToolTip, quit sioyek before rename zotfile, 695, 95
SetTimer, RemoveToolTip, -1500
Return

!j::
KeyWait,j,T0.3 ;wait 0.5 seconds for release key
If (ErrorLevel) ;more than 0.5 sec have passed
{
    WhichWindow("ahk_exe WindowsTerminal.exe", "WindowsTerminal.exe")
    FixedWindow("ahk_exe WindowsTerminal.exe", 0, 49.9999)
    FixedWindow("ahk_exe sioyek.exe" , 49.9999, 49.9999)
KeyWait,j ;prevent sending n after notepad opened
}
Else
{
    WhichWindow("ahk_exe WindowsTerminal.exe", "wt.exe")
    ToolTip, Zotero(P) Terminal(J) Sioyek(K) Chrome(N), 695, 95
SetTimer, RemoveToolTip, -1500
}
Return

;=========================================
; MOVE WINDOW TO NEXT DESKTOP CTRL+SHIFT+ALT+ARROW
;=========================================


^#+Left::
n := VD.getCurrentDesktopNum()
if n = 1
{
    Return
}
n -= 1
VD.MoveWindowToDesktopNum("A",n), VD.goToDesktopNum(n)
Return

^#+Right::
n := VD.getCurrentDesktopNum()
if n = % VD.getCount()
{
    Return
}
n += 1
VD.MoveWindowToDesktopNum("A",n), VD.goToDesktopNum(n)
Return



;=========================================
; TOGGLE MAXIMIZE
;=========================================

!space::
WinGet, windowState, MinMax, A
    if (windowState = 1) {
        WinRestore, A
    } else {
        WinMaximize, A
    }
return

!enter::
WinGetClass, class, A
if (class = "XLMAIN" || class = "OpusApp") {
    ; Let Alt+Enter behave normally in Excel or Word
    Send !{Enter}
    return
}

; For other applications, toggle maximize / restore
WinGet, windowState, MinMax, A
if (windowState = 1) {
    WinRestore, A
} else {
    WinMaximize, A
}
return


#enter::
Process, Exist, WindowsTerminal.exe
If Not ErrorLevel ; errorlevel will = 0 if process doesn't exist
{
Run, "%UserProfile%\AppData\Local\Microsoft\WindowsApps\wt.exe"
Sleep, 10
Run, "sioyek.exe"
Sleep, 10
Run, "chrome.exe"
Sleep, 10
Run, "zotero.exe"
}
Else
    MsgBox, % "Please, Close Terminal`n`n"
    WinActivate,% "ahk_pid  " ErrorLevel
Return

!;::
    AltTab()
    WinGetTitle, title, A
    ToolTip, %title%, 295, 495
    SetTimer, RemoveToolTip, -1500
Return



;=========================================
;Vertical Bar Key
;=========================================


~PgUp up::
toggle := !toggle
if (toggle)
    ;Send, ^#{Right}  ; Switches to the next virtual desktop in Windows 11.
	AltTab()
else
    ;Send, ^#{Left}  ; Switches to the previous virtual desktop in Windows 11.
AltTab()
return

PgUp::
If !start                      ; If time marker is not set,
 start := A_TickCount          ;  then set it to the current "time", to mark the start of key-down
Send {Blind}{vkE8}             ; Disable Start menu activation while allowing use of LWin as a modifier
Return                         ; See https://www.autohotkey.com/docs/v1/lib/_MenuMaskKey.htm#Remarks

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

~End up::
If (A_PriorKey = "End"        ; If no keys were pressed after LWin,
 && A_TickCount - start < 300) ;  and key-up occurred shortly after key-down,
        ;AltTab()           ; If yes, run stuff
        WinActivate, ahk_exe zoom.exe
start := 0                     ; Reset the time marker
Return

End::
If !start                      ; If time marker is not set,
 start := A_TickCount          ;  then set it to the current "time", to mark the start of key-down
Send {Blind}{vkE8}             ; Disable Start menu activation while allowing use of LWin as a modifier
Return                         ; See https://www.autohotkey.com/docs/v1/lib/_MenuMaskKey.htm#Remarks


double_tap_tab() {
    Static last := 0             ; Permanent variable to track last press

    If (A_TickCount - last < 175) ; Diff current tick from last tick. Has it been 500ms?
		{
        AltTab()           ; If yes, run stuff
    WinGetTitle, title, A
    ToolTip, %title%, 295, 495
SetTimer, RemoveToolTip, -1500
        last := 0                 ; Then set last to 0. This prevents a triple tap from firing
		}
	Else
		{
		last := A_TickCount     ; If it hasn't been 500ms, set last press to current tick
		}
	return
}

!esc::
    WinGetTitle, title, A
    WinActivate, %title%
    WinGet, proc, ProcessName, A
    WinGet, win, List, ahk_exe %proc%
    Loop, %win%
     uid := win%A_Index%
    WinActivate, ahk_id %uid%

    Return

;*~enter::double_tap_enter()

double_tap_enter() {
    Static last := 0             ; Permanent variable to track last press

    If (A_TickCount - last < 400) ; Diff current tick from last tick. Has it been 500ms?
		{
    WinGet, proc, ProcessName, A
    WinGet, win, List, ahk_exe %proc%
    Loop, %win%
     uid := win%A_Index%
    WinActivate, ahk_id %uid%
    WinGetTitle, title, A
    ToolTip, %title%, 295, 495
SetTimer, RemoveToolTip, -1500
        last := 0                 ; Then set last to 0. This prevents a triple tap from firing
		}
	Else
		{
		last := A_TickCount     ; If it hasn't been 500ms, set last press to current tick
		}
	return
}

;=========================================
; Way to Activate chrome instance
;=========================================

; !n::
; KeyWait,n,T0.3 ;wait 0.5 seconds for release key
; If (ErrorLevel) ;more than 0.5 sec have passed
; {
;     uid := WinActive("A")
;     SoundBeep, 1500, 100 ; Mark the active window
; KeyWait,n ;prevent sending n after notepad opened
; }
; Else
; {
;     WinActivate, ahk_id %uid% ;Activate the marked window
;     ; WinActivate, ahk_id %uid%
;     ToolTip, hold !n to mark the window, 695, 95
;     SetTimer, RemoveToolTip, -1500
; }
; Return

; F2::
; WinGetTitle, title, A
; MsgBox, "%title%"

!c::
WinGetActiveTitle, Title
Clipboard := StrSplit( Title, ".").1
Return

#IfWinActive ahk_exe zotero.exe
F1::
zotmsg =
(
Alt+f searchbox
Alt+d addtags
Alt+w sidebartoggle
Alt+w sidebartoggle
)
SplashTextOn, 300, 100, Message #1, %zotmsg%,
Sleep, 5000
SplashTextOff
Return
#IfWinActive

#IfWinActive ahk_exe zotero.exe
!f:: Send, ^f
#IfWinActive

#IfWinActive ahk_exe zotero.exe
!d:: Send, ^d
#IfWinActive

#IfWinActive ahk_exe zotero.exe
!w::
KeyWait,w,T0.3 ;wait 0.5 seconds for release key
If (ErrorLevel) ;more than 0.5 sec have passed
{
    Send, +[
    KeyWait,w ;prevent sending n after notepad opened
}
Else
{
	SetKeyDelay, 200, 50 ;SetKeyDelay , Delay, PressDuration
	Send, +[
	Send, +]
}
Return
#IfWinActive

#IfWinActive ahk_exe chrome.exe
F2:: Send, ^!a
#IfWinActive

#IfWinActive ahk_exe chrome.exe
F1::
chromsg =
(
Alt+d grouptab
F2 sharegdrive
Alt+w closegroup
Alt+1-4 togglegroup
)
ToolTip, %chromsg%
Sleep, 5000
ToolTip
Return
#IfWinActive

;=========================================
; help
;=========================================
F1::
msg =
(
Alt+j terminal
Alt+k sioyek
Alt+h zotero
Alt+l chrome
AltShift+j jenni
Alt+= equalwindow
AltShift+= onequarterwindow
Alt+- onequarterwindow
Alt+Space fullscreen
Double tab switchwindow
Double Enter switchinstance
)
SplashTextOn, 300, 400, Message #1, %msg%,
Sleep, 5000
SplashTextOff
Return

#IfWinActive ahk_exe sioyek.exe
*CapsLock::
    Send {Blind}{Ctrl Down}
    cDown := A_TickCount
Return

*CapsLock up::
    ; Modify the threshold time (in milliseconds) as necessary
    If ((A_TickCount-cDown) < 150)
        Send {Blind}{Ctrl Up}{Esc}
    Else
        Send {Blind}{Ctrl Up}
Return
#IfWinActive

#IfWinActive ahk_exe WindowsTerminal.exe
*CapsLock::
    Send {Blind}{Ctrl Down}
    cDown := A_TickCount
Return

*CapsLock up::
    ; Modify the threshold time (in milliseconds) as necessary
    If ((A_TickCount-cDown) < 150)
        Send {Blind}{Ctrl Up}{Esc}
    Else
        Send {Blind}{Ctrl Up}
Return
#IfWinActive

!`::
toggle := !toggle
if (toggle)
    Send, ^#{Right}  ; Switches to the next virtual desktop in Windows 11.
else
    Send, ^#{Left}  ; Switches to the previous virtual desktop in Windows 11.
return

;~#tab up::
;toggle := !toggle
;if (toggle)
;    Send, ^#{Right}  ; Switches to the next virtual desktop in Windows 11.
;else
;    Send, ^#{Left}  ; Switches to the previous virtual desktop in Windows 11.
;return

;#tab::
;If !start                      ; If time marker is not set,
; start := A_TickCount          ;  then set it to the current "time", to mark the start of key-down
;Send {Blind}{vkE8}             ; Disable Start menu activation while allowing use of LWin as a modifier
;Return                         ; See https://www.autohotkey.com/docs/v1/lib/_MenuMaskKey.htm#Remarks

; =========================================
; Microsoft Excel
; =========================================
#IfWinActive ahk_exe EXCEL.EXE
F1:: SendInput, {Alt down}{Alt up}hvst{Enter}
F3:: SendInput, {Alt down}{Alt up}hvsf{Enter}
F4:: SendInput, {Alt down}{Alt up}hvv
;F4:: SendInput, {Alt down}{Alt up}hv ;across softwre
F10:: SendInput, {Alt down}{Alt up}hfd{s}
F8:: SendInput, {Alt down}{Alt up}hoh
F9:: SendInput, {Alt down}{Alt up}hoa
F6:: SendInput, ^m ;configure in macros options
F11::
Stop := false
Loop, 4
{
    if (Stop)
        break
    Send, ^+e
    Sleep, 300
    Send, {Enter}
    Sleep, 300
}
return
F12::^+t

#v:: SendInput, {Alt down}{Alt up}hvsl
#w:: ^F1
#r::               ; Alt + R
    Send, ^+=      ; Tekan Ctrl+Shift+=
    Sleep, 200     ; Tunggu 200 ms (atur sesuai kebutuhan)
    Send, r{Enter} ; Ketik r lalu Enter
return
!f::
toggle := !toggle
if (toggle)
    Send, !wff
else
    Send, !wfu
return

^Space:: Send, {F5 down}{F5 up}{enter} ;goto linked ref

$Shift::
KeyWait, Shift, T.3
If ErrorLevel {
 SoundBeep, 1500
 Send {Shift down}
 KeyWait, Shift
 SoundBeep, 1000
 Send {Shift up}
} Else Send % A_PriorHotkey = A_ThisHotkey && A_TimeSincePriorHotkey < 400 ? "^[" : ""
Return

$LCtrl::
KeyWait, LCtrl, T0.3  ; wait up to 0.3s for release
if (ErrorLevel) {
    ; held down
    SoundBeep, 1500
    Send, {LCtrl down}
    KeyWait, LCtrl
    SoundBeep, 1000
    Send, {LCtrl up}
} else {
    ; single or double tap logic
    if (A_PriorHotkey = A_ThisHotkey && A_TimeSincePriorHotkey < 400) {
        chromsg =
    (LTrim
    ctrl help (double)
    F1 paste format
    F3 paste only formula
    F4 paste only value/match formatting
    Win+v paste link
    F5 go to
    F6 Colorize cell
    F8 Row height input
    F9 Row height standard
    F10 select visible cell only
    F11-F12 Assigned Macros
    Shift go to ref (double)
    Ctrl+shift go last view
    Alt+(F11>i>m) create macros module
    Alt+F8 macros
    ; Macros map ctrl+shift+(q-t)
    ; `` / stop recurring macro (hold)
    `` / ctrl+shift+x switchcolour temp
    Win+w hide ribbon (maximize)
    Alt+= autosum (visible cell)
    Alt+f Freeze/unfreeze pane toggle
    Win+r add full row above
    )

    ToolTip, %chromsg%
    Sleep, 6000
    ToolTip
    } else {
        Send, {Esc}  ; single press action (you can change this)
    }
}
return

; Robust single / double / hold for the backtick key (`).
; AutoHotkey v1.1

#SingleInstance Force
SetBatchLines -1
global TapCount := 0

$`::SendInput, ^c





#IfWinActive

; Alt + = autosum only visible cell
;=========================================
!SC00D::
<^>!SC00D::
if	WinActive("ahk_exe EXCEL.EXE")
{
	xl :=	ComObjActive("Excel.Application"), c :=	xl.Selection
	 , c.Formula :=	"=SUBTOTAL(109," xl.Range(c.Offset(-1,0),c.Offset(-1,0).End(-4162)).Address(0,0) ")"
}
else	Send, ≠
return

;=========================================
; Microsoft Word
;=========================================
#IfWinActive ahk_exe word.exe

F3:: Send, {Alt down}{Alt up}hvh {enter} ;paste formating

#IfWinActive

; =========================================
; Spotify
; =========================================

#IfWinActive ahk_exe spotify.EXE
!.::SoundSet,+5

!,::SoundSet,-5
#IfWinActive

; =========================================
; Always on top
; =========================================
; Press Ctrl+Shift+Space to set any currently active window to be always on top.
; Press Ctrl+Shift+Space again set the window to no longer be always on top.
; Source: https://www.howtogeek.com/196958/the-3-best-ways-to-make-a-window-always-on-top-on-windows

~Home::
	WinGetTitle, activeWindow, A
	if IsWindowAlwaysOnTop(activeWindow) {
		notificationMessage := "The window """ . activeWindow . """ is now always on top."
		notificationIcon := 16 + 1 ; No notification sound (16) + Info icon (1)
	}
	else {
		notificationMessage := "The window """ . activeWindow . """ is no longer always on top."
		notificationIcon := 16 + 2 ; No notification sound (16) + Warning icon (2)
	}
	Winset, Alwaysontop, , A
	TrayTip, Always-on-top, %notificationMessage%, , %notificationIcon%
	Sleep 3000 ; Let it display for 3 seconds.
	HideTrayTip()

	IsWindowAlwaysOnTop(windowTitle) {
		WinGet, windowStyle, ExStyle, %windowTitle%
		isWindowAlwaysOnTop := if (windowStyle & 0x8) ? false : true ; 0x8 is WS_EX_TOPMOST.
		return isWindowAlwaysOnTop
	}

	HideTrayTip() {
		TrayTip  ; Attempt to hide it the normal way.
		if SubStr(A_OSVersion,1,3) = "10." {
			Menu Tray, NoIcon
			Sleep 200  ; It may be necessary to adjust this sleep.
			Menu Tray, Icon
		}
	}
Return

;=========================================
; Autodesk AUtocad
;=========================================

#IfWinActive ahk_exe acad.exe
;ahk class of palette window can be checked in window spy ahk by over cursor in the window
F1::
toggle := !toggle
    if (toggle)
        SendInput, RIBBON{Enter}
    else
        SendInput, RIBBONCLOSE{Enter}
return

SetTitleMatchMode, 2  ; allows partial title matches

F2::
    ; Check if the Layer Properties Manager palette is open
    if WinExist("Layer")
    {
        SendInput, LAYERCLOSE{Enter}
        toggle := false
    }
    else
    {
        SendInput, LAYER{Enter}
        toggle := true
    }
return

F3::
    ; Try to find the Blocks palette window by title (partial match)
    If WinExist("Blocks")
    {
        SendInput, BLOCKSPALETTECLOSE{Enter}
        toggle := false
    }
    else
    {
        SendInput, INSERT{Enter}
        toggle := true
    }
return

SetTitleMatchMode, 2  ; allows partial title matches (e.g., "Sheet Set" anywhere in the title)

F4::
    ; Check if the Sheet Set Manager palette is open
    if WinExist("Sheet Set Manager")
    {
        SendInput, SHEETSETHIDE{Enter}  ; hides or closes the palette
        toggle := false
    }
    else
    {
        SendInput, SHEETSET{Enter}       ; opens the palette
        toggle := true
    }
return

F5::^1

F12::Send, ^0

$LCtrl::
KeyWait, LCtrl, T0.3  ; wait up to 0.3s for release
if (ErrorLevel) {
    ; held down
    SoundBeep, 1500
    Send, {LCtrl down}
    KeyWait, LCtrl
    SoundBeep, 1000
    Send, {LCtrl up}
} else {
    ; single or double tap logic
    if (A_PriorHotkey = A_ThisHotkey && A_TimeSincePriorHotkey < 400) {
        chromsg =
        (
	ctrl help
        F1 ribbon
        F2 toggle layer
        F3 toggle block
        F4 toggle sheetset
        F5 properties
        F12 fullscreen
        1 copy
        2 move
        3 rotate
        4 mirror
        5 dimlinear
        6 xline
        7 dimcontinue
        8 copybase
        e matchprop
        z laymcurer
        r textedit
        q quickproperties
        )
        ToolTip, %chromsg%
        Sleep, 5000
        ToolTip
    } else {
        Send, {Esc}  ; single press action (you can change this)
    }
}
return



#IfWinActive

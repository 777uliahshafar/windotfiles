; ************************
; Most common programs
; ************************


RemoveToolTip:
ToolTip
return

;-----------------------------------------------------------------
; Check whether the target window is activation target
; Alt- tab function for remapping
;-----------------------------------------------------------------
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

; ************************
; Window Arrangement (Windows Terminal, Chrome, Sioyek)
; ************************

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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; RESIZE WINDOW
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; SWITCH BETWEEN WINDOW
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; TOGGLE MAXIMIZE
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!space::
WinGet, windowState, MinMax, A
    if (windowState = 1) {
        WinRestore, A
    } else {
        WinMaximize, A
    }
return

!enter::
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

; Replace home and Windows key function
; This script blocks the Start menu alone but leaves it enabled with other keys.
; Briefly tapping LWin sends ALT-SPACE.
; The script uses a "time marker" to indicate when LWin was pressed.
; This enables the script to distinguish a short hold from a long hold.
~LWin Up::
If (A_PriorKey = "LWin"        ; If no keys were pressed after LWin,
 && A_TickCount - start < 300) ;  and key-up occurred shortly after key-down,
        AltTab()           ; If yes, run stuff
start := 0                     ; Reset the time marker
Return

~LWin::
If !start                      ; If time marker is not set,
 start := A_TickCount          ;  then set it to the current "time", to mark the start of key-down
Send {Blind}{vkE8}             ; Disable Start menu activation while allowing use of LWin as a modifier
Return                         ; See https://www.autohotkey.com/docs/v1/lib/_MenuMaskKey.htm#Remarks

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;; Vertical Bar Key ----;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;


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
        AltTab()           ; If yes, run stuff
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

*~enter::double_tap_enter()

double_tap_enter() {
    Static last := 0             ; Permanent variable to track last press

    If (A_TickCount - last < 200) ; Diff current tick from last tick. Has it been 500ms?
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; Way to Activate chrome instance
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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
!a:: Send, ^!a
#IfWinActive

#IfWinActive ahk_exe chrome.exe
F1::
chromsg =
(
Alt+d grouptab
Alt+a sharegdrive
Alt+w closegroup
Alt+1-4 togglegroup
)
SplashTextOn, 300, 100, Message #1, %chromsg%,
Sleep, 5000
SplashTextOff
Return
#IfWinActive



F10::
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

; ************************
; Excel
; ************************

#IfWinActive ahk_exe EXCEL.EXE
F3::^!v

F4:: ^[
#IfWinActive

; ************************
; Always on top
; ************************
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

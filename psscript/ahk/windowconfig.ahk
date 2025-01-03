﻿; ************************
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

WhichWindow(winTitle,winProg){
	 If WinExist(winTitle) {
	; MsgBox, %XNew% - %WNew% ; DEBUG
    WinActivate, %winTitle%
    WinGet, proc, ProcessName, A
    WinGet, win, List, ahk_exe %proc%
    Loop, %win%
     uid := win%A_Index%
    WinActivate, ahk_id %uid%
    ; WinRestore, %winTitle%
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

!n::
    WhichWindow("ahk_exe chrome.exe", "chrome.exe")
    ToolTip, Zotero(P) Terminal(J) Sioyek(K) Chrome(N), 695, 95
SetTimer, RemoveToolTip, -1500
Return

!k::
    WhichWindow("ahk_exe sioyek.exe", "sioyek.exe")
    ToolTip, Zotero(P) Terminal(J) Sioyek(K) Chrome(N), 695, 95
SetTimer, RemoveToolTip, -1500
Return

!p::
    WhichWindow("ahk_exe zotero.exe", "zotero.exe")
    ToolTip, Zotero(P) Terminal(J) Sioyek(K) Chrome(N), 695, 95
SetTimer, RemoveToolTip, -1500
Return

!j::
    WhichWindow("ahk_exe WindowsTerminal.exe", "WindowsTerminal.exe")
    ToolTip, Zotero(P) Terminal(J) Sioyek(K) Chrome(N), 695, 95
SetTimer, RemoveToolTip, -1500
Return

!esc::
KeyWait,esc,T0.3 ;wait 0.5 seconds for release key
If (ErrorLevel) ;more than 0.5 sec have passed
{
    if WinActive("ahk_exe WindowsTerminal.exe")
    SwitchWindow("ahk_exe zotero.exe")
    if WinActive("ahk_exe sioyek.exe")
    SwitchWindow("ahk_exe zotero.exe")
    else if WinActive("ahk_exe chrome.exe")
    SwitchWindow("ahk_exe zotero.exe")
    KeyWait,esc ;prevent sending n after notepad opened
}
Else ;less than 2 sec have passed
{
    if WinActive("ahk_exe sioyek.exe")
    ; SwitchWindow("ahk_exe WindowsTerminal.exe")
        AltTab()
    else if WinActive("ahk_exe chrome.exe")
    ; SwitchWindow("ahk_exe WindowsTerminal.exe")
        AltTab()
    else if WinActive("ahk_exe zotero.exe")
        AltTab()
    else if WinActive("ahk_exe WindowsTerminal.exe")
        AltTab()
}

Return
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; TOGGLE MAXIMIZE
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

!enter::
WinGet, windowState, MinMax, A
    if (windowState = 1) {
        WinRestore, A
    } else {
        WinMaximize, A
    }
return

^+j::
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


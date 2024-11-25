; ************************
; Windows Key and Alt Key Switch
; ************************
Alt::LWin
#F4::!F4


LWin::Alt

<#Tab:: AltTab()

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
        WinActivate, ahk_id %this_ID%, ,2
            break
    }
}

;-----------------------------------------------------------------
; Check whether the target window is activation target
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
	 If WinExist(winTitle) {
	; MsgBox, %XNew% - %WNew% ; DEBUG
	WinRestore, %WinTitle%
	WinMove, %WinTitle%,, %XNew%, %TopNew%, %WNew%, %HNew%
	WinActivate
} Else MsgBox 48, Error, % "Window was not found.`n`n" winTitle
}

AltWindow(winTitle,XP, WP) {

	; Get Taskbar height
	WinGetPos,,, tbW, tbH, ahk_class Shell_TrayWnd
	
	; Calculate new position and size
	XNew := (A_ScreenWidth * XP / 100)
	WNew := (A_ScreenWidth * WP / 100)
	HNew := (A_ScreenHeight - tbH)
	TopNew := 2
	 If WinExist(winTitle) {
	; MsgBox, %XNew% - %WNew% ; DEBUG
	WinRestore, %WinTitle%
	WinMove, %WinTitle%,, %XNew%, %TopNew%, %WNew%, %HNew%
} Else MsgBox 48, Error, % "Window was not found.`n`n" winTitle
}

F9::
FixedWindow("ahk_exe WindowsTerminal.exe", 0, 62.2222)
FixedWindow("ahk_exe sioyek.exe" , 62.2222, 33.3333)
Return

F10::
FixedWindow("ahk_exe WindowsTerminal.exe", 0, 33.3333)
FixedWindow("ahk_exe sioyek.exe" , 34.4444, 66.66666)
AltWindow("ahk_exe chrome.exe" , 34.4444, 66.66666)
Return

F8::
WinActivate, % chrome := "ahk_exe chrome.EXE"
WinMaximize, %chrome%
Return

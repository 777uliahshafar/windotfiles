; ************************
; Most common programs
; ************************



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

QSwitchWindow(winTitle){
	 If WinExist(winTitle) {
	; MsgBox, %XNew% - %WNew% ; DEBUG
    ; WinActivate, %winTitle%
   Send !{Tab}
    ; WinRestore, %winTitle%
} Else MsgBox 48, Error, % "Window was not found.`n`n" winTitle
}


!1::
FixedWindow("ahk_exe WindowsTerminal.exe", 0, 62.2222)
FixedWindow("ahk_exe sioyek.exe" , 62.2222, 33.3333)
AltWindow("ahk_exe chrome.exe" , 62.2222, 33.3333)
Return

!2::
FixedWindow("ahk_exe WindowsTerminal.exe", 0, 33.3333)
FixedWindow("ahk_exe sioyek.exe" , 34.4444, 66.66666)
AltWindow("ahk_exe chrome.exe" , 34.4444, 66.66666)
Return

!3::
FixedWindow("ahk_exe WindowsTerminal.exe", 0, 49.9999)
FixedWindow("ahk_exe sioyek.exe" , 49.9999, 49.9999)
AltWindow("ahk_exe chrome.exe" , 49.9999, 49.99999)
Return

!w::
Toggle := !Toggle
If (Toggle)
{
WinActivate, % sioyek := "ahk_exe sioyek.EXE"
WinMaximize, %sioyek%
}
else
{
WinActivate, % chrome := "ahk_exe chrome.EXE"
WinMaximize, %chrome%
}
return ;using return to end the hotkey definition.

!enter::
Toggle := !Toggle
If (Toggle)
{
WinActivate, % wtmax := "ahk_exe WindowsTerminal.EXE"
WinMaximize, %wtmax%
}
else
{
WinActivate, % wtmin := "ahk_exe WindowsTerminal.EXE"
WinRestore, %wtmin%
}
return ;using return to end the hotkey definition.



!c::
Toggle := !Toggle
If (Toggle)
{
    SwitchWindow("ahk_exe chrome.exe")
}else
{
    AltTab()
}
Return

!s::
Toggle := !Toggle
If (Toggle)
{
    SwitchWindow("ahk_exe sioyek.exe")
}else
{
    AltTab()
}
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
    SwitchWindow("ahk_exe WindowsTerminal.exe")
    else if WinActive("ahk_exe chrome.exe")
    SwitchWindow("ahk_exe WindowsTerminal.exe")
    else if WinActive("ahk_exe zotero.exe")
        AltTab()
    else if WinActive("ahk_exe WindowsTerminal.exe")
        AltTab()
}
Return


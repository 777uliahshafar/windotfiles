Alt::LWin
<#F4::!F4


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

;********************************************************************************
; Resize Windows by 1/3 by Jeff Sherk - November 2022
; AutoHotKey script for resizing a window by 1/3 or 2/3 of screen size.
; This script is very helpful if you have a very wide monitor and want to quickly resize multiple windows to fit on your screen.
;   WinKey +AltKey +RightArrowKey = CYCLE window size from 33% 1/3 Left > 66% 2/3 Left > 33% 1/3 Middle > 66% 2/3 Right > 33% 1/3 Right.
;   WinKey +AltKey +LeftArrowKey = CYCLE back thru above sizes.
;   CtrlKey +WinKey +AltKey +LeftArrowKey = Direct resize window to 66% 2/3 Left.
;   CtrlKey +WinKey +AltKey +RightArrowKey = Direct resize window to 33% 1/3 Right.
;********************************************************************************
; - Forked from this script: https://gist.github.com/zemax/7337507
; - Since Windows already has built in functionality for resizing windows to 50% using WinKey +ArrowKey, I removed that functionality from original.
; - I added hardcoded direct resize (not cyled) to 2/3 left and 1/3 right.
;********************************************************************************

; SETUP
   ; #InstallKeybdHook   	 ; Debug:
   ; #Warn   		 	 ; Debug: Enable warnings to assist with detecting common errors.
   #NoEnv   			; Recommended for performance and compatibility with future AutoHotkey releases.
   SendMode Input   		; Recommended for new scripts due to its superior speed and reliability.
   SetWorkingDir %A_ScriptDir%	; Ensures a consistent starting directory.

; ICON
   I_Icon = %A_ScriptDir%\WindowResizeByThirds.ico	; Use a .ico file of your choice or https://iwebss.com/download/WindowResizeByThirds.ico
   ICON [I_Icon]                               		; Changes a compiled script's icon (.exe)
   if I_Icon <>
   IfExist, %I_Icon%
      Menu, Tray, Icon, %I_Icon%    			; Changes menu tray icon 

; NOTES
   ; https://autohotkey.com/docs/Hotkeys.htm
   ; + for SHIFT
   ; ^ for CTRL
   ; ! for ALT
   ; ~ use this first if you do not want to block the keystroke from other tasks


; ************************
; Script starts here
; ************************

MoveCycle(Add) {
	static StepsInCycle = 5 ;;; This is how many different window positions we will have.
	static SizeCycle = 0
	SizeCycle := Mod(SizeCycle + Add, StepsInCycle)
	if (SizeCycle < 0) {
		SizeCycle := SizeCycle + StepsInCycle
	}
	if (Add = 333) {
		SizeCycle = 3 ;;; Force Left 2/3
	}
	else if (Add = 222) {
		SizeCycle = 0 ;;; Force Right 1/3
	}
else if (Add = 444) {
		SizeCycle = 4 ;;; Force Right 1/3
	}
else if (Add = 111) {
		SizeCycle = 1 ;;; Force Right 1/3
	}

	;;; These IF statements need to have same number of options as StepsInCycle.
	;;; So if StepsInCycle = 5 then we need 5 IF statements ranging from 0 to 4.
	if (SizeCycle = 0) {
		MoveWindow(0, 33.3333) ;;; Left 1/3
	}
	else if (SizeCycle = 1) {
		MoveWindow(0, 66.6666) ;;; Left 2/3
	}
	else if (SizeCycle = 3) {
		MoveWindow(33.3333, 66.6666) ;;; Right 2/3
	}
	else if (SizeCycle = 4) {
		MoveWindow(66.6666, 33.3333) ;;; Right 1/3
	}
}

MoveWindow(XP, WP) {
	; Get current Window
	WinGetActiveTitle, WinTitle
	WinGetPos, X, Y, WinWidth, WinHeight, %WinTitle%
	
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
#Up::
	; Windows key + Left arrow ; Cycle left
	MoveCycle(-1)
return

#Down::
	; Windows key + Right arrow ; Cycle right
	MoveCycle(1)
return


;^Right::
	; CTRL + Windows key + Left arrow ; Force Left 2/3
	;MoveCycle(111)
;return

;^Left::
	; CTRL + Windows key + Left arrow ; Force Left 2/3
	;MoveCycle(333)
;return

^+Right::
	; CTRL + Windows key + Left arrow ; Force Left 2/3
	MoveCycle(444)
return

^+Left::
	; CTRL + Windows key + Right arrow ; Force Right 1/3
	MoveCycle(222)
return
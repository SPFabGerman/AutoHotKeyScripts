#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CoordMode, ToolTip, Screen
global numLockOn := GetKeyState("NumLock", "T")
displayNumLock()
Gosub, initCommands
createGUI()
return

#Include, CommandList.ahk
#Include, AutohotkeyShell.ahk

; Removes Tooltip
removeTooltip:
    ToolTip
    return

; Changes Icon and Displays Tooltip, acording to numLockOn
displayNumLock(){
    If (numLockOn = 1){
        ToolTip, Numbers active, A_ScreenWidth, A_ScreenHeight-55
        Menu, Tray, Icon, Icons/num_1.ico
    }else{
        ToolTip, Functions active, A_ScreenWidth, A_ScreenHeight-55
        Menu, Tray, Icon, Icons/fun_F.ico
    }
    SetTimer, removeTooltip, -3000
    return
}

; Change NumLock State (numLockOn)
NumLock::
    numLockOn := !numLockOn
    SetNumLockState, %numLockOn%
    displayNumLock()
    return

; Show GUI
NumpadIns::
    command := showGUI(CommandArray)
    if (command != "" and command != " ")
        Gosub %command%
    return

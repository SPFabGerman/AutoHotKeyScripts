#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CoordMode, ToolTip, Screen
global numLockOn := GetKeyState("NumLock", "T")
displayNumLock()
Gosub, initCommands
createGUI()
insertListCommandArray := parseInsertListFile()
return

#Include, CommandList.ahk
#Include, AutohotkeyShell.ahk
#Include, HelperFunctions.ahk

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

parseInsertListFile(){
    local
    FileRead, file, InsertList.txt ; Read the input file

    CommandArray := []

    ; parse it line by line
    Loop, parse, file, `n, `r
    {
        ; exclude empty lines (e.g. last line)
        if (A_LoopField = "")
        {
            Continue
        }

        arr := StrSplit(A_LoopField, "|") ; split array to seperate command and replacement
        CommandArray.Push(arr[2] . "`t- " . arr[1])
    }

    return sortArray(CommandArray)
}

; Change NumLock State (numLockOn)
NumLock::
    numLockOn := !numLockOn
    SetNumLockState, %numLockOn%
    displayNumLock()
    return

; 0: Show GUI
NumpadIns::
    command := showGUI(CommandArray)
    if (command != "" and command != " ")
        Gosub %command%
    return

; 1: Insert Hotstring
NumpadEnd::
    result := showGUI(insertListCommandArray)
    if (result != "" and result != " "){
        arr := StrSplit(result, "- ")
        Send, % arr[2]
    }
    return

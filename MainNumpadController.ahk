#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

CoordMode, ToolTip, Screen
global numLockOn := GetKeyState("NumLock", "T")
displayNumLock()
Gosub, initCommands
Gosub, createGUI

#Include, CommandList.ahk

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

; initializes the gui for later use
createGUI:
    global ASH_Input_Box
    global ASH_Input_List_Index
    Gui, ASH:New,,Autohotkey SHell
    Gui, ASH:Add, Edit, r1 vASH_Input_Box gASH_Input_Box_Change,
    Gui, ASH:Add, ListBox, r5 vASH_Input_List_Index +AltSubmit, %CommandArrayString%
    GuiControl, Choose, ASH_Input_List_Index, 1
    return

ASH_Input_Box_Change:
    GuiControlGet, ASH_Input_Box, ASH:
    GuiControl, ChooseString, ASH_Input_List_Index, %ASH_Input_Box%
    return

#IfWinActive, Autohotkey SHell
Enter::
    Gui, ASH:Submit
    Gosub, % CommandArray[ASH_Input_List_Index]
    return

Down::
    GuiControlGet, curIndex, ASH:, ASH_Input_List_Index,
    curIndex := curIndex + 1
    if (curIndex > CommandCount){
        curIndex := CommandCount
    }
    GuiControl, ASH:Choose, ASH_Input_List_Index, %curIndex%
    return

Up::
    GuiControlGet, curIndex, ASH:, ASH_Input_List_Index,
    curIndex := curIndex - 1
    if (curIndex <= 0){
        curIndex := 1
    }
    GuiControl, ASH:Choose, ASH_Input_List_Index, %curIndex%
    return

Tab::return

Escape::
    Gui, ASH:Hide
    return

#IfWinActive

; Change NumLock State (numLockOn)
NumLock::
    numLockOn := !numLockOn
    SetNumLockState, %numLockOn%
    displayNumLock()
    return

; Show GUI
NumpadIns::
    GuiControl, ASH:Choose, ASH_Input_List_Index, 1
    GuiControl, ASH:Text, ASH_Input_Box, 
    Gui, ASH:Show,,
    return

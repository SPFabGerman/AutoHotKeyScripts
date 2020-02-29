; initializes the gui for later use
createGUI(){
    global ASH_Input_Box
    global ASH_Input_List_Index
    global ASH_Finished = 0
    global ASH_Cancel = 0

    Gui, ASH:New,,Autohotkey SHell
    Gui, ASH:Add, Edit, r1 vASH_Input_Box gASH_Input_Box_Change,
    Gui, ASH:Add, ListBox, r5 vASH_Input_List_Index +AltSubmit,
    GuiControl, ASH:Choose, ASH_Input_List_Index, 10
    return
}

ASH_Input_Box_Change:
    GuiControlGet, ASH_Input_Box, ASH:
    GuiControl, ASH:ChooseString, ASH_Input_List_Index, %ASH_Input_Box%
    return

#IfWinActive, Autohotkey SHell
Enter::
    Gui, ASH:Submit
    ASH_Cancel = 0
    ASH_Finished = 1
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
    ASH_Cancel = 1
    ASH_Finished = 1
    return

#IfWinActive

showGUI(CommandArray){
    global ASH_Input_Box
    global ASH_Input_List_Index
    global ASH_Finished
    global ASH_Cancel

    GuiControl, ASH:Text, ASH_Input_Box, 

    CommandArrayString := "|" + Join("|", CommandArray*)
    GuiControl, ASH:, ASH_Input_List_Index, %CommandArrayString%
    GuiControl, ASH:Choose, ASH_Input_List_Index, 1

    ASH_Finished = 0
    ASH_Cancel = 0

    Gui, ASH:Show,,

    While !ASH_Finished
        Sleep 100
    
    if (ASH_Cancel){
        return ""
    }

    return CommandArray[ASH_Input_List_Index]
}

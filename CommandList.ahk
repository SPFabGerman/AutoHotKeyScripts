#Include, HelperFunctions.ahk

initCommands:
    ; === Add Commands Here === 
    global CommandArray := [" ", "reload", "stop", "help", "edit", "launch"]
    CommandArray := sortArray(CommandArray)
    global CommandCount := CommandArray.MaxIndex()
    global commandArrayString := Join("|", CommandArray*)
    Return

reload:
    Reload
    return

stop:
    ExitApp
    return

help:
    MsgBox, , Autohotkey Shell Help, % "Available Commands:`n - " + Join("`n - ", CommandArray*)

edit:
    Run, "C:\Users\Fabian\AppData\Local\Programs\Microsoft VS Code\Code.exe" %A_ScriptDir%
    return

launch:
    Run explore %A_ScriptDir%
    return

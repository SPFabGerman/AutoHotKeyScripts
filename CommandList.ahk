#Include, HelperFunctions.ahk

initCommands:
    ; === Add Commands Here === 
    global CommandArray := ["reload", "stop", "help"]
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

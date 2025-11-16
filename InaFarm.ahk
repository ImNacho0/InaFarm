#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Screen
#SingleInstance Force
SetTitleMatchMode 2
#WinActivateForce
SetWinDelay 0
#Include <Vis2>

games := 0
tries := 0
GoSub, CreateGUI 

Return

; =======================================================
; GUI
; =======================================================

CreateGUI:
    Gui, MacroGameCounter:New, +AlwaysOnTop +ToolWindow +Caption -MaximizeBox -MinimizeBox  
    Gui, Font, s12 Bold, Verdana
    Gui, MacroGameCounter:Add, Text, vGameCountText x0 y0 w150 h40 Center, Partidos: 0
    Gui, MacroGameCounter:Add, Text, vTriesCountText x0 y40 w150 h40 Center, Intentos: 0
    Gui, MacroGameCounter:Add, Text, vToggleText x0 y60 w150 h40 Center +cFF0000, Desactivado
    Gui, MacroGameCounter:Show, x0 y0 w150 h80, InaFarm (@ImNacho)
Return

MacroGameCounterGuiClose:
ExitApp

; =======================================================
; HOTKEYS Y CONTROL DE LA MACRO
; =======================================================

F1::
    Toggle := !Toggle
    If (Toggle) {
        SetTimer, MainMacroLoop, 500 
        GuiControl, MacroGameCounter:+c00AA00, ToggleText
        GuiControl, MacroGameCounter:, ToggleText, Activado
        MsgBox, 0, Macro Control, Macro INICIADA (F1 para detener)
    } Else {
        SetTimer, MainMacroLoop, Off
        GuiControl, MacroGameCounter:+cFF0000, ToggleText
        GuiControl, MacroGameCounter:, ToggleText, Desactivado
        MsgBox, 0, Macro Control, Macro DETENIDA
    }
Return

F3::ExitApp

; ===========
; Main Loop
; ===========
MainMacroLoop:
tried := OCR([840, 50, 240, 40], "eng")
start := OCR([1300, 900, 200, 50], "eng")
time := OCR([900, 95, 140, 35], "eng")
If start contains Todo listo
{
    tries += 1
    Send, {e}
    GoSub, UpdateGameCounter
}
Else
{
    Send, {Alt}{Enter}
    Sleep, 500
}
If (tries = 5)
{
    Send, {Escape}
    tries := 0
}
If tried contains Estadio
{
    tries := 0
    GoSub, UpdateGameCounter
}
Else If tried contains Municipal
{
    tries := 0
    GoSub, UpdateGameCounter
}
If time contains 2º
{
    games += 1
    GoSub, UpdateGameCounter
    Sleep, 3000
    Send, {v Down}
    Sleep, 7000
    Send, {v Up}
}
Else If time contains 2:00
{
    games += 1
    Sleep, 3000
    GoSub, UpdateGameCounter
    Send, {v Down}
    Sleep, 7000
    Send, {v Up}
}

Return

UpdateGameCounter:
    GuiControl, MacroGameCounter:, GameCountText, Partidos: %games%
    GuiControl, MacroGameCounter:, TriesCountText, Intentos: %tries%
    GuiControl, MacroGameCounter:+c00AA00, ToggleText
    GuiControl, MacroGameCounter:, ToggleText, Activado
Return
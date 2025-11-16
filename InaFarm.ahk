#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Screen
#SingleInstance Force
SetTitleMatchMode 2
#WinActivateForce
SetWinDelay 0
#Include <Vis2>

games := 0 
GoSub, CreateGUI 

Return

; =======================================================
; GUI
; =======================================================

CreateGUI:
    Gui, MacroGameCounter:New, +AlwaysOnTop +ToolWindow +Caption -MaximizeBox -MinimizeBox  
    Gui, Font, s12 Bold, Verdana
    Gui, MacroGameCounter:Add, Text, vGameCountText x0 y0 w150 h40 Center, Partidas Jugadas: 0
    Gui, MacroGameCounter:Show, x0 y0 w150 h40, InaFarm (@ImNacho)
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
        MsgBox, 0, Macro Control, Macro INICIADA (F1 para detener)
    } Else {
        SetTimer, MainMacroLoop, Off
        MsgBox, 0, Macro Control, Macro DETENIDA
    }
Return

F3::ExitApp

; ===========
; Main Loop
; ===========
MainMacroLoop:
    start := OCR([1300, 900, 200, 50], "eng")
    time := OCR([900, 95, 140, 35], "eng")
    
    ; --- Bloque 1: Iniciar el partido ---
    If start contains Todo listo
    {
        Send, {e}
    }
    Else
    {
        Send, {Alt}{Enter}
        Sleep, 500
    }
    
    ; --- Bloque 2: Fin de la ronda y contar ---
    If time contains 2º
    {
        games += 1
        GoSub, UpdateGameCounter ; Llama a la subrutina de actualización
        Sleep, 3000
        Send, {v Down}
        Sleep, 7000
        Send, {v Up}
    }
    Else If time contains 2:00
    {
        games += 1
        GoSub, UpdateGameCounter ; Llama a la subrutina de actualización
        Sleep, 3000
        Send, {v Down}
        Sleep, 7000
        Send, {v Up}
    }
Return

UpdateGameCounter:
    GuiControl, MacroGameCounter:, GameCountText, Partidas Jugadas: %games%
Return
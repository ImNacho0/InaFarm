; Script solo para actualizar el EXE
GitHubUser := "ImNacho0"
GitHubRepo := "InaFarm" 
EXE_URL := "https://github.com/" GitHubUser "/" GitHubRepo "/releases/latest/download/InaFarm_Launcher.exe"

; Esperar a que el main se cierre
Sleep, 1000

; Descargar nuevo EXE
UrlDownloadToFile, %EXE_URL%, InaFarm_new.exe
if !ErrorLevel {
    FileMove, InaFarm_Launcher.exe, InaFarm_old.exe, 1
    FileMove, InaFarm_new.exe, InaFarm_Launcher.exe, 1
    Run, InaFarm_Launcher.exe
    FileSetAttrib, +H, InaFarm_Launcher.exe
}
ExitApp
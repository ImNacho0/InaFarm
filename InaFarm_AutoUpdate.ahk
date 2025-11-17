GitHubUser := "ImNacho0"
GitHubRepo := "InaFarm"

IfNotExist, tools
    FileCreateDir, tools

EXE_URL := "https://github.com/" GitHubUser "/" GitHubRepo "/releases/latest/download/latest.exe"
apiURL := "https://api.github.com/repos/" GitHubUser "/" GitHubRepo "/releases/latest"
BIN_ZIP_URL := "https://github.com/" GitHubUser "/" GitHubRepo "/archive/refs/heads/resources.zip"

UrlDownloadToFile, %apiURL%, tools\latest.json
FileRead, json, tools\latest.json
RegExMatch(json, """tag_name""\s*:\s*""([^""]+)""", version)

Sleep, 1000

UrlDownloadToFile, %EXE_URL%, tools\latest_new.exe
if !ErrorLevel {
    FileMove, tools\latest.exe, tools\latest_old.exe, 1
    FileMove, tools\latest_new.exe, tools\latest.exe, 1
    MsgBox, 64, Actualizacion, Actualizado a version %version1%
}

FileSetAttrib, +H, tools\latest.exe

UrlDownloadToFile, %BIN_ZIP_URL%, tools\resources.zip

IfNotExist, tools\resources_unzip
    FileCreateDir, tools\resources_unzip

RunWait, powershell -NoLogo -NoProfile -Command "Expand-Archive 'tools/resources.zip' 'tools/resources_unzip' -Force",, Hide

IfNotExist, tools\bin
    FileCreateDir, tools\bin

FileMoveDir, tools\resources_unzip\%GitHubRepo%-resources\bin, tools\bin, 1

FileDelete, tools\resources.zip
FileRemoveDir, tools\resources_unzip, 1

ExitApp

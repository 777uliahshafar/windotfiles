# What my shortcut is pointing at
$ShortcutTarget = "C:\Users\uliah\AppData\Local\Microsoft\WindowsApps\Microsoft.WindowsTerminal_8wekyb3d8bbwe\wt.exe"
# Where my shortcut will be saved and how it will be named
$ShortcutFile = "${PSScriptRoot}\removecamscanner.lnk"
$ArgumentsToSourceExe = "pwsh -NoLogo $env:USERPROFILE\windotfiles\psscript\removecamscanner.ps1"

$WScriptShell = New-Object -ComObject WScript.Shell
$shortcut = $WScriptShell.CreateShortcut($ShortcutFile)

$Shortcut.TargetPath = $ShortcutTarget
$Shortcut.Arguments = $ArgumentsToSourceExe
$Shortcut.Save()

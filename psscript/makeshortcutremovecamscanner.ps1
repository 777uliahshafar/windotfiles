# What my shortcut is pointing at
$WScriptShell = New-Object -ComObject WScript.Shell
$ShortcutTarget = "C:\Users\uliah\AppData\Local\Microsoft\WindowsApps\Microsoft.WindowsTerminal_8wekyb3d8bbwe\wt.exe"
$style = 7
# Where my shortcut will be saved and how it will be named
$ShortcutFile = "${PSScriptRoot}\removecamscanner.lnk"
$ArgumentsToSourceExe = "pwsh -NoLogo $env:USERPROFILE\windotfiles\psscript\removecamscanner.ps1"

$shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $ShortcutTarget
$shortcut.WindowStyle = $style
$Shortcut.Arguments = $ArgumentsToSourceExe
$Shortcut.Save()

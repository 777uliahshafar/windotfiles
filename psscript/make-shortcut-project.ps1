# What my shortcut is pointing at
$ShortcutTarget = "C:\Users\uliah\AppData\Local\Microsoft\WindowsApps\Microsoft.WindowsTerminal_8wekyb3d8bbwe\wt.exe"
# Where my shortcut will be saved and how it will be named
$CollectShortcutFile = "${PSScriptRoot}\pro-collect.lnk"
$ArgumentsToCollectSourceExe = "pwsh -NoLogo $env:USERPROFILE\windotfiles\psscript\pro-collect.ps1"
$RenameShortcutFile = "${PSScriptRoot}\pro-rename.lnk"
$ArgumentsToRenameSourceExe = "pwsh -NoLogo $env:USERPROFILE\windotfiles\psscript\pro-rename.ps1"

$WScriptShell = New-Object -ComObject WScript.Shell
$shortcut = $WScriptShell.CreateShortcut($CollectShortcutFile)

$Shortcut.TargetPath = $ShortcutTarget
$Shortcut.Arguments = $ArgumentsToCollectSourceExe
$Shortcut.Save()

$WScriptShell = New-Object -ComObject WScript.Shell
$shortcut = $WScriptShell.CreateShortcut($RenameShortcutFile)

$Shortcut.TargetPath = $ShortcutTarget
$Shortcut.Arguments = $ArgumentsToRenameSourceExe
$Shortcut.Save()

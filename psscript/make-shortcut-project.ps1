# What my shortcut is pointing at
$WScriptShell = New-Object -ComObject WScript.Shell
$ShortcutTarget = "C:\Users\uliah\AppData\Local\Microsoft\WindowsApps\Microsoft.WindowsTerminal_8wekyb3d8bbwe\wt.exe"
$style = 7
# Where my shortcut will be saved and how it will be named
$CollectShortcutFile = "${PSScriptRoot}\pro-collect.lnk"
$ArgumentsToCollectSourceExe = "pwsh -NoLogo $env:USERPROFILE\windotfiles\psscript\pro-collect.ps1"
$RenameShortcutFile = "${PSScriptRoot}\pro-rename.lnk"
$ArgumentsToRenameSourceExe = "pwsh -NoLogo $env:USERPROFILE\windotfiles\psscript\pro-rename.ps1"
$AssShortcutFile = "${PSScriptRoot}\ass-rename.lnk"
$ArgumentsToAssSourceExe = "pwsh -NoLogo $env:USERPROFILE\windotfiles\psscript\ass-rename.ps1"
$StampShortcutFile = "${PSScriptRoot}\pro-watermark.lnk"
$ArgumentsToStampSourceExe = "pwsh -NoLogo $env:USERPROFILE\windotfiles\psscript\pro-watermark.ps1"

$shortcut = $WScriptShell.CreateShortcut($CollectShortcutFile)
$Shortcut.TargetPath = $ShortcutTarget
$shortcut.WindowStyle = $style
$Shortcut.Arguments = $ArgumentsToCollectSourceExe
$Shortcut.Save()

$shortcut = $WScriptShell.CreateShortcut($RenameShortcutFile)

$Shortcut.TargetPath = $ShortcutTarget
$shortcut.WindowStyle = $style
$Shortcut.Arguments = $ArgumentsToRenameSourceExe
$Shortcut.Save()

$shortcut = $WScriptShell.CreateShortcut($AssShortcutFile)

$Shortcut.TargetPath = $ShortcutTarget
$shortcut.WindowStyle = $style
$Shortcut.Arguments = $ArgumentsToAssSourceExe
$Shortcut.Save()


$shortcut = $WScriptShell.CreateShortcut($StampShortcutFile)

$Shortcut.TargetPath = $ShortcutTarget
$shortcut.WindowStyle = $style
$Shortcut.Arguments = $ArgumentsToStampSourceExe
$Shortcut.Save()

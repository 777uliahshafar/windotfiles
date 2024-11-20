# What my shortcut is pointing at
$WScriptShell = New-Object -ComObject WScript.Shell
$ShortcutTarget = "C:\Users\uliah\AppData\Local\Microsoft\WindowsApps\Microsoft.WindowsTerminal_8wekyb3d8bbwe\wt.exe"
$style = 7
# Where my shortcut will be saved and how it will be named
$BackupShortcutFile = "${PSScriptRoot}\pro-backup.lnk"
$ArgumentsToBackupSourceExe = "pwsh -NoLogo $env:USERPROFILE\windotfiles\psscript\pro-backup.ps1"
$RenameShortcutFile = "${PSScriptRoot}\pro-rename.lnk"
$ArgumentsToRenameSourceExe = "pwsh -NoLogo $env:USERPROFILE\windotfiles\psscript\pro-rename.ps1"
$AssShortcutFile = "${PSScriptRoot}\pro-assets.lnk"
$ArgumentsToAssSourceExe = "pwsh -NoLogo $env:USERPROFILE\windotfiles\psscript\pro-assets.ps1"
$StampShortcutFile = "${PSScriptRoot}\pro-watermark.lnk"
$ArgumentsToStampSourceExe = "pwsh -NoLogo $env:USERPROFILE\windotfiles\psscript\pro-watermark.ps1"

$shortcut = $WScriptShell.CreateShortcut($BackupShortcutFile)
$Shortcut.TargetPath = $ShortcutTarget
$shortcut.WindowStyle = $style
$Shortcut.Arguments = $ArgumentsToBackupSourceExe
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

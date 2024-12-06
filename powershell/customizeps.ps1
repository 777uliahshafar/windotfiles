$pspath = "$env:USERPROFILE\.config\powershell\"

Get-ChildItem -Path $PSScriptRoot\* -Recurse -Include *.ps1 -Exclude *make* -File | Copy-Item -Destination $pspath

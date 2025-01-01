Get-ChildItem -Path $env:USERPROFILE\windotfiles\psscript\compresspdf.bat -Include *.bat -File | Copy-Item -Destination ".\"


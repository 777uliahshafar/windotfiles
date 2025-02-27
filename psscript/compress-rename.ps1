. (Join-Path $PSScriptRoot Variable.ps1)

$files = Get-ChildItem -Path $comdocpath


foreach ($file in $files) {
    Where-Object Name -match '-compressed' |
    Rename-Item -NewName { $_.Name.Replace($Matches[0], '') }
}

foreach ($file in $files) {
    $name = $file.Name
    $fullname = $file.FullName
    $extension = $file.Extension
    $RemoveName = (Get-Culture).textinfo.tolower($file.BaseName.tolower()) -replace '-compressed',''
    $base = $RemoveName

    if ($name -Match $verFiles ) {
        Rename-Item $fullname "$base$extension"
    }
}


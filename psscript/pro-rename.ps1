. (Join-Path $PSScriptRoot Variable.ps1)

$files = Get-ChildItem -Path $renamepath -Exclude *raw*, *rev*, *ver*

foreach ($file in $files) {
    $name = $file.Name
    $fullname = $file.FullName
    $extension = $file.Extension
    $dir = $file.Directory.Name
    $CapitalizedName = (Get-Culture).textinfo.tolower($file.BaseName.tolower()) -replace '\W','-'
    $base = $CapitalizedName
    $suf = "REV"
    $counter = 1
    $random = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 2 | ForEach-Object {[char]$_})

    if ($name -Match $revFiles ) {
        Rename-Item $fullname "$base-$dir-$suf-$random$extension"
    $counter++
    }
}

foreach ($file in $files) {
    $name = $file.Name
    $fullname = $file.FullName
    $extension = $file.Extension
    $dir = $file.Directory.Name
    $CapitalizedName = (Get-Culture).textinfo.tolower($file.BaseName.tolower()) -replace '\W','-'
    $base = $CapitalizedName
    $suf = "ver"
    $counter = 1
    $random = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 4 | ForEach-Object {[char]$_})
    if ($name -Match $verFiles ) {
        Rename-Item $fullname "$base-$dir-$suf-$random$extension"
    $counter++
    }
}

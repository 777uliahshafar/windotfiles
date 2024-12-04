. (Join-Path $PSScriptRoot Variable.ps1)

$files = Get-ChildItem -Path $propath\assets -Exclude *rw*, *rev*, *ver*

foreach ($file in $files) {
    $name = $file.Name
    $fullname = $file.FullName
    $extension = $file.Extension
    $CapitalizedName = (Get-Culture).textinfo.tolower($file.BaseName.tolower()) -replace '\W','-' -replace '_','-' -replace '-','-'
    $base = $CapitalizedName
    $suf = "rw"
    $counter = 1
    $random = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 4 | ForEach-Object {[char]$_})
    if ($name -Match $assFiles ) {
        Rename-Item $fullname "$base-$suf-$random$extension"
    $counter++

    }
}


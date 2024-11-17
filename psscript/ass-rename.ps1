. ./variable.ps1

$files = Get-ChildItem -Path $asspath -Exclude *raw*, *rev*, *ver*

foreach ($file in $files) {
    $name = $file.Name
    $fullname = $file.FullName
    $extension = $file.Extension
    $CapitalizedName = (Get-Culture).textinfo.tolower($file.BaseName.tolower()) -replace '\W','-'
    $base = $CapitalizedName
    $suf = "raw"
    $counter = 1
    $random = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 8 | ForEach-Object {[char]$_})
    if ($name -Match $assFiles ) {
        Rename-Item $fullname "$base-$suf-$random$extension"
    $counter++

    }
}

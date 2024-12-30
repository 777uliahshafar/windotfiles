. (Join-Path $PSScriptRoot Variable.ps1)

$files = Get-ChildItem -Path $docpath -Exclude *bkd*.pdf, *bkd*.jpg, *bkd*.jpeg, *bkd*.png, *.ps1, *.bat

foreach ($file in $files) {
    $name = $file.Name
    $fullname = $file.FullName
    $extension = $file.Extension
    $dir = $file.Directory.Name
    $CapitalizedName = (Get-Culture).textinfo.tolower($file.BaseName.tolower()) -replace '\W','-'
    $base = $CapitalizedName

    if ($name -Match $docFiles  ) {
        Rename-Item $fullname "$base-$dir$extension"
    }
}

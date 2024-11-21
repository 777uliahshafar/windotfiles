$files = Get-ChildItem -Path "D:\lecture\bkd-2024-1" -Exclude *bkd*.pdf, *bkd*.jpg, *bkd*.png, *bkd*.jpeg
foreach ($file in $files) {
    $name = $file.Name
    $fullname = $file.FullName
    $extension = $file.Extension
    $dir = $file.Directory.Name
    $CapitalizedName = (Get-Culture).textinfo.tolower($file.BaseName.tolower()) -replace '\W','-'
    $base = $CapitalizedName
    $counter = 1

    if ($name -Match ".*.pdf|.*.jpg|.*.png|.*.jpeg" ) {
        Rename-Item $fullname "$base-$dir$extension"
    $counter++
    }
}

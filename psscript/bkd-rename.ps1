$bkdFiles = ".*.pdf|.*.jpg|.*.png|.*.jpeg"
$bkdpath = "D:\lecture\bkd-2024-1"
$files = Get-ChildItem -Path $bkdpath -Exclude *bkd*.pdf, *bkd*.jpg, *bkd*.jpeg, *bkd*.png

foreach ($file in $files) {
    $name = $file.Name
    $fullname = $file.FullName
    $extension = $file.Extension
    $dir = $file.Directory.Name
    $CapitalizedName = (Get-Culture).textinfo.tolower($file.BaseName.tolower()) -replace '\W','-'
    $base = $CapitalizedName

    if ($name -Match $bkdFiles  ) {
        Rename-Item $fullname "$base-$dir$extension"
    }
}

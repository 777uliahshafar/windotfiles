. (Join-Path $PSScriptRoot Variable.ps1)

$files = Get-ChildItem -Path $asspath -Exclude *rw*, *rev*, *ver*

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

magick *.jpg -sampling-factor 4:2:0 -strip -quality 80 -interlace JPEG -colorspace sRGB -set filename:f "%t-compress" '%[filename:f].jpg' && magick *.jpeg -sampling-factor 4:2:0 -strip -quality 80 -interlace JPEG -colorspace sRGB -set filename:f "%t-compress" '%[filename:f].jpg' && magick *.png -sampling-factor 4:2:0 -strip -quality 80 -colorspace sRGB -set filename:f "%t-compress" '%[filename:f].png'

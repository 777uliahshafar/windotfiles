$path = "."
$fileTypes = ".*.jpg|.*.bmp|.*.png|.*.gif|.*.tif"
$files = Get-ChildItem -exclude "bg.jpg", "chamaeleon_hochformat.png", "guide.png", "kopfhoerer.png" -Recurse | Where-Object FullName -Match ".*$path*"
$counter = 1
$dir = ""

foreach ($file in $files) {
    $name = $file.Name
    $fullname = $file.FullName
    $extension = $file.Extension
$random = -join ((48..57) + (65..90) + (97..122) | Get-Random -Count 4 | ForEach-Object {[char]$_})
$number = Get-Random -Min (11) -Max 99

    if ($name -Match $fileTypes) {
        if ($dir -ne $file.Directory.Name) {
            $dir = $file.Directory.Name
            $counter = 1
        }

        $zero = If ( $counter -le 9) { "0" } Else { "" }

        Rename-Item $fullname "$number-$random$extension"

        $counter++
    }
}

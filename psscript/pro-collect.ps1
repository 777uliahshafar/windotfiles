$source = "D:\projectfiles\*" # it should include \*
$destination = "D:\projectfiles\assets"
# $format = '*.txt', '*.docx', '*.jpg', '*.png'
$rawFiles = '*.jpg', '*.png','*.jpeg','*.tif','*.tiff','*.bmp','*.eps','*.heic','*.raw','*.psb','*.psdc','*.webp'

Write-Host "Moving all files in '$($source)' to '$($destination)'"
Get-ChildItem -Path $source -File -Include $rawFiles | ForEach-Object {
    $destPath = Join-Path -Path $destination -ChildPath $_.Name
    if (Test-Path $destPath) {
        $counter = 1
        while (Test-Path $destPath) {
            $destPath = Join-Path -Path $destination -ChildPath (“{0}-{1}{2}” -f $_.BaseName, $counter, $_.Extension)
            $counter++
        }
    }
    Move-Item -Path $_.FullName -Destination $destPath -whatif
}

# run to stop script: Unregister-Event FileCreated
$folder = 'D:\projectfiles' # Enter the root path you want to monitor.
$filter = ''  # You can enter a wildcard filter here.

$fsw = New-Object IO.FileSystemWatcher $folder, $filter -Property @{IncludeSubdirectories = $false;NotifyFilter = [IO.NotifyFilters]'FileName, LastWrite'}

Register-ObjectEvent $fsw Created -SourceIdentifier FileCreated -Action {
$source = "D:\projectfiles\*" # it should include \*
$destination = "D:\projectfiles\assets"
$rawFiles = '*.txt', '*.docx', '*.jpg', '*.png'
Write-Host "Moving all files in '$($source)' to '$($destination)'"
Get-ChildItem -Path $source -File -Include $rawFiles | ForEach-Object {
    $destPath = Join-Path -Path $destination -ChildPath $_.Name
    if (Test-Path $destPath) {
        $counter = 1
        while (Test-Path $destPath) {
            $destPath = Join-Path -Path $destination -ChildPath (“{0}-{1}{2}” -f $_.BaseName, $counter, $_.Extension)
            $counter++
        }
    }
    Move-Item -Path $_.FullName -Destination $destPath
}
}


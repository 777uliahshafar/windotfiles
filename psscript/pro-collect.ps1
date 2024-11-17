. ./variable.ps1

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

# run to stop script: Unregister-Event FileCreated
$filter = ''  # You can enter a wildcard filter here.

$fsw = New-Object IO.FileSystemWatcher $folder, $filter -Property @{IncludeSubdirectories = $false;NotifyFilter = [IO.NotifyFilters]'FileName, LastWrite'}

Register-ObjectEvent $fsw Created -SourceIdentifier FileCreated -Action {
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

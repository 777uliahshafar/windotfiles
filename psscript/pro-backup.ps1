. (Join-Path $PSScriptRoot Variable.ps1)

Write-Host "Moving raw files in '$($source)' to '$($destination)'"
Get-ChildItem -Path $source -File -Include $transferFiles *rev* -Exclude *raw*, *ver* | ForEach-Object {
    $destPath = Join-Path -Path $destination -ChildPath $_.Name
    if (Test-Path $destPath) {
        $counter = 1
        while (Test-Path $destPath) {
            $destPath = Join-Path -Path $destination -ChildPath (“{0}-{1}{2}” -f $_.BaseName, $counter, $_.Extension)
            $counter++
        }
    }
    Copy-Item -Path $_.FullName -Destination $destPath
}

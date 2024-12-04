. (Join-Path $PSScriptRoot Variable.ps1)

If(!(test-path -PathType container $propath\temp))
{
      New-Item -ItemType Directory -Path $propath\temp
}

Get-ChildItem -Path $propath\* -File -Include $cleanFiles | ForEach-Object {
    $destPath = Join-Path -Path $propath\temp -ChildPath $_.Name
    if (Test-Path $destPath) {
        $counter = 1
        while (Test-Path $destPath) {
            $destPath = Join-Path -Path $propath\temp -ChildPath (“{0}-{1}{2}” -f $_.BaseName, $counter, $_.Extension)
            $counter++
        }
    }
    Move-Item -Path $_.FullName -Destination $destPath
}

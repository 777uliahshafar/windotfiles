. (Join-Path $PSScriptRoot Variable.ps1)

mkdir -p $propath\backup
Get-ChildItem -Path $propath\* -File -Include $transferFiles *rev* -Exclude *raw*, *ver* | ForEach-Object {
    $destPath = Join-Path -Path $propath\backup -ChildPath $_.Name
    if (Test-Path $destPath) {
        $counter = 1
        while (Test-Path $destPath) {
            $destPath = Join-Path -Path $propath\backup -ChildPath (“{0}-{1}{2}” -f $_.BaseName, $counter, $_.Extension)
            $counter++
        }
    }
    Copy-Item -Path $_.FullName -Destination $destPath
}

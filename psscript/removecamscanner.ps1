. (Join-Path $PSScriptRoot Variable.ps1)

cd ${rmpath}
mkdir ./crop
magick mogrify -gravity South -chop 0x72 -rotate "+90>" -path ./crop *.jpg

Write-Host -NoNewLine 'Press any key to generate pdf...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

cd crop
magick *.jpg -page A4 -strip -kuwahara "1.5" -modulate "100,90" -level "5,92%,0.74" -set filename:f "%t-paper" '%[filename:f].pdf'


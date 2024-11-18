. .\"variableonlytweakme.ps1"

cd ${rmpath}
mkdir ./crop
magick mogrify -gravity South -chop 0x72 -rotate "+90>" -path ./crop *.jpg

Write-Host -NoNewLine 'Press any key to generate pdf...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

cd crop
magick *.jpg -compress JPEG -quality 90 -page A4 -density 72 -set filename:f "%t-paper" '%[filename:f].pdf'


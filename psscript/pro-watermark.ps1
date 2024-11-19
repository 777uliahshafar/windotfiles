. (Join-Path $PSScriptRoot Variable.ps1)

$files = Get-ChildItem -Path $stamppath

#Check if the source file exists
If (Test-Path $stampcheckFile) {
foreach ($file in $files) {
magick mogrify -gravity southeast -geometry +10+10 -draw "image Over 0,0 320,100 '$PSScriptRoot\watermark\trans_stamp3.png'" -path $stamppath\publish $stamppath\*ver*.jpg $stamppath\*ver*.png
}
} else {
magick -list font > $PSScriptRoot\watermark\fonts.txt
magick -size 320x100 xc:transparent -font Segoe-UI-Italic -pointsize 72 -fill black -annotate +24+64 'AHFA' -fill white -annotate +26+66 'AHFA' -fill transparent  -annotate +25+65 'AHFA' $PSScriptRoot\watermark\trans_stamp.png
magick -size 320x100 xc:black -font Segoe-UI-Italic -pointsize 72 -fill white   -annotate +24+64 'AHFA' -fill white   -annotate +26+66 'AHFA' -fill black   -annotate +25+65 'AHFA' $PSScriptRoot\watermark\mask_mask.jpg

magick composite -compose CopyOpacity $PSScriptRoot\watermark\mask_mask.jpg   $PSScriptRoot\watermark\trans_stamp.png $PSScriptRoot\watermark\trans_stamp3.png

magick mogrify -gravity southeast -geometry +10+10 -draw "image Over 0,0 320,100 '$PSScriptRoot\watermark\trans_stamp3.png'" -path $stamppath\publish $stamppath\*ver*.jpg $stamppath\*ver*.png
}

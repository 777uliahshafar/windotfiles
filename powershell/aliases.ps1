# Function to Aliases current direcotry
function getchildtex { dir .\* -include ('*.tex', '*.bib') -recurse }
function nvimconfig { set-location "$env:LOCALAPPDATA\nvim" }
function obsidiansearch
{
    nvim -c "ObsidianSearch"
}

function nvimalias
{
    cd '~/.config/powershell'
    & 'nvim' '.\aliases.ps1'
}

function obsidian
{
    cd '~/obs'
    & 'nvim' '.\1714384690-MAIN.md'
}

function cropbottomsideimg
{
magick *.jpg  -gravity South -chop 0x72 -set filename:f "%t-chop" '%[filename:f].jpg' &&  magick *.png  -gravity South -chop 0x72 -set filename:f "%t-chop" '%[filename:f].png' &&  magick *.jpeg  -gravity South -chop 0x72 -set filename:f "%t-chop" '%[filename:f].jpeg' &&  magick *.tif  -gravity South -chop 0x72 -set filename:f "%t-chop" '%[filename:f].tif' &&  magick *.tiff  -gravity South -chop 0x72 -set filename:f "%t-chop" '%[filename:f].tiff' &&  magick *.eps  -gravity South -chop 0x72 -set filename:f "%t-chop" '%[filename:f].eps' &&  magick *.heic  -gravity South -chop 0x72 -set filename:f "%t-chop" '%[filename:f].heic' &&  magick *.webp  -gravity South -chop 0x72 -set filename:f "%t-chop" '%[filename:f].webp' &&  magick *.raw  -gravity South -chop 0x72 -set filename:f "%t-chop" '%[filename:f].raw'
}

function obsprop
{
    cd '~/obs'
    & 'nvim' '.\1709363398-JGCC.md'
}

function obseng
{
    cd '~/obs'
    & 'nvim' '.\1719618861-VQGL.md'
}




function element
{
    cd 'D:\element'
    & 'nvim' '.\element.tex'
}

function proposalstudy
{
    cd 'D:\phdprop\'
    & 'nvim' '.\subfiles\aasprop.tex'
}

function essay
{
    cd 'D:\essay\subfiles'
}

function aasessay
{
    cd 'D:\essay\subfiles\'
    & 'nvim' '.\aasessay.tex'
}

function karakter
{
    cd 'D:\karakter\'
    & 'nvim' '.\karakter.tex'
}



# Alias
Set-Alias al alias
Set-Alias v nvim
Set-Alias o obsidian
Set-Alias ll getchildtex
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias nc nvimconfig
Set-Alias na nvimalias
Set-Alias nvc vimmyhelp

# Set-Alias phd phdjournal
Set-Alias st statistika
Set-Alias int interviewbpi

Set-Alias el element
Set-Alias pr proposalstudy
Set-Alias es essay
Set-Alias as aasessay
Set-Alias ka karakter
Set-Alias vp obsprop
Set-Alias ve obseng
Set-Alias cropbot cropbottomsideimg

# Function to Aliases current direcotry
function getchildtex { dir .\* -include ('*.tex', '*.bib') -recurse }
function nvimconfig { set-location "$env:LOCALAPPDATA\nvim" }

function lstex {
    Get-ChildItem -Path "D:\","E:\" -Filter "*.tex" -recurse | Select-Object -ExpandProperty Directory | Get-Unique
}

function obsidiansearch
{
    nvim -c "ObsidianSearch"
}

function nvimalias
{
    cd '~/windotfiles/powershell'
    & 'nvim' '.\aliases.ps1'
}

function nvimmyhelp
{
    cd '~/vim-myhelp/doc/'
    & 'nvim' '.\mycheat.txt'
}

function obsidian
{
    cd '~/obs'
    & 'nvim' '.\1714384690-MAIN.md'
}

function compressjpghere
{
magick *.jpg -sampling-factor 4:2:0 -strip -quality 80 -interlace JPEG -colorspace sRGB -set filename:f "%t-compressed" '%[filename:f].jpg'
}

function compressjpeghere
{
magick *.jpeg -sampling-factor 4:2:0 -strip -quality 80 -interlace JPEG -colorspace sRGB -set filename:f "%t-compressed" '%[filename:f].jpg'
}

function compresspnghere
{
magick *.png -sampling-factor 4:2:0 -strip -quality 80 -colorspace sRGB -set filename:f "%t-compressed" '%[filename:f].png'
}

function pdf2jpeghere
{
magick *.pdf -density 150 -quality 100 -flatten -sharpen 0x1.0 -set filename:f "%t-converted" '%[filename:f].jpg'
}

# Other function
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
    cd 'D:\karakterAA\'
    & 'nvim' '.\karakter.tex'
}



# Alias
Set-Alias al alias
Set-Alias v nvim
Set-Alias lt lstex
Set-Alias o obsidian
Set-Alias ll getchildtex
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias nc nvimconfig
Set-Alias na nvimalias
Set-Alias nh nvimmyhelp

# Set-Alias magal magickaliases
# Set-Alias proal projectaliases

# Magick Alias
Set-Alias compressjpg compressjpghere
Set-Alias compressjpeg compressjpeghere
Set-Alias compresspng compresspnghere
Set-Alias pdf2img pdf2jpeghere

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

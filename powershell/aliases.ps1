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
    cd '~/.config/windotfiles/powershell'
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

function variable
{
    cd '~/.config/windotfiles/psscript'
    & 'nvim' '.\Variable.ps1'
}

function artikel
{
    git clone git@github.com:777uliahshafar/simart-templ.git
echo "'mv simart_templ newname' to rename folder"
}

function keynote
{
    git clone git@github.com:777uliahshafar/keynote-templ.git
echo "'mv keynote_templ newname' to rename folder"
}

function compressjpghere
{
magick *.jpg -sampling-factor 4:2:0 -strip -quality 80 -interlace JPEG -colorspace sRGB -set filename:f "%t-compressed" '%[filename:f].jpg'
}

function montagejpghere
{
echo "magick montage filname*.jpg -tile 2x -geometry 640x480+10+10 filename-result.jpg"
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

function omitrename
{
Get-ChildItem -File | Where-Object {
    $_.Name -match '[_-]compressed'
} | ForEach-Object {

    $newName = $_.Name -replace '[_-]compressed', ' sm'
    $target  = Join-Path $_.DirectoryName $newName

    if (-not (Test-Path $target)) {
        Rename-Item $_ $target
    }
}
}

function renamebkdfolder
{
Get-ChildItem -File | ForEach-Object {

    $parent = $_.Directory.Name.ToLower()
    $ext    = $_.Extension.ToLower()

    $name = $_.BaseName.ToLower()

    # dash & underscore → space
    $name = $name -replace '[-_]', ' '

    # remove everything except letters, numbers, spaces
    $name = $name -replace '[^a-z0-9 ]', ''

    # normalize spaces
    $name = ($name -replace '\s+', ' ').Trim()

    # only append parent folder if not already present at the end
    if ($name -notmatch "\b$([Regex]::Escape($parent))$") {
        $name = "$name $parent"
    }

    $newName = "$name$ext"
    $target  = Join-Path $_.DirectoryName $newName

    if ($newName -ne $_.Name -and -not (Test-Path $target)) {
        Rename-Item $_ $target
    }
}
}

function renamestandardfile
{
Get-ChildItem -File | ForEach-Object {

    $ext  = $_.Extension.ToLower()
    $name = $_.BaseName.ToLower()

    # dash & underscore → space
    $name = $name -replace '[-_]', ' '

    # keep only letters, numbers, spaces
    $name = $name -replace '[^a-z0-9 ]', ''

    # normalize spaces
    $name = ($name -replace '\s+', ' ').Trim()

    $newName = "$name$ext"
    $target  = Join-Path $_.DirectoryName $newName

    if ($newName -ne $_.Name -and -not (Test-Path $target)) {

        # force case change on Windows
        $temp = Join-Path $_.DirectoryName ("__tmp__" + $_.Name)
        Rename-Item $_ $temp
        Rename-Item $temp $target
    }
}
}

function project
{
    Get-ChildItem -Path $env:USERPROFILE\.config\windotfiles\psscript\makeshortcutproject.ps1  -File | Copy-Item -Destination .\ && . .\makeshortcutproject.ps1
}

function camscanner
{
    Get-ChildItem -Path $env:USERPROFILE\.config\windotfiles\psscript\makeshortcutremovecamscanner.ps1  -File | Copy-Item -Destination .\ && . .\makeshortcutremovecamscanner.ps1
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
    cd 'D:\lecture\hibah2025\elemen\'
    & 'nvim' '.\element.tex'
}

function proposalstudy
{
    cd 'D:\usulandoktor\'
    & 'nvim' '.\subfiles\spvprop.tex'
}

function bkdnature
{
    cd 'D:\usulandoktor\'
    & 'nvim' '.\subfiles\bkdnature.tex'
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

function usulanbpi
{
    cd 'D:\usulandrplace'
    & 'nvim' '.\usulandrbpi.tex'
}

function usulandosbin
{
    cd 'D:\usulandrplace'
    & 'nvim' '.\usulandosbin.tex'
}

function hibahint
{
    cd 'D:\hibahint2025\'
    & 'nvim' '.\hibahint.tex'
}

function morfologi
{
    cd 'D:\morfologi\'
    & 'nvim' '.\morfologi.tex'
}




# line 222 was set to show aliases
# Alias
# Show aliases sa
Set-Alias v nvim
Set-Alias lt lstex
Set-Alias o obsidian
Set-Alias la getchildtex
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias nc nvimconfig
Set-Alias na nvimalias
Set-Alias nh nvimmyhelp
Set-Alias va variable
Set-Alias getkeynote keynote
Set-Alias getsimart artikel

# File name treats
Set-Alias rmcompressed omitrename
Set-Alias bkdrename renamebkdfolder
Set-Alias filesrename renamestandardfile


# Magick Alias
Set-Alias compressjpg compressjpghere
Set-Alias compressjpeg compressjpeghere
Set-Alias montagejpg montagejpghere
Set-Alias compresspng compresspnghere
Set-Alias pdf2img pdf2jpeghere
Set-Alias getproject project
Set-Alias getremovecamscanner camscanner

# Set-Alias phd phdjournal
Set-Alias st statistika
Set-Alias int interviewbpi
Set-Alias el element
Set-Alias pr proposalstudy
Set-Alias bk bkdnature
Set-Alias es essay
Set-Alias as aasessay
Set-Alias ka karakter
Set-Alias vp obsprop
Set-Alias ve obseng
Set-Alias hi hibahint
Set-Alias ub usulanbpi
Set-Alias ud usulandosbin
Set-Alias mo morfologi


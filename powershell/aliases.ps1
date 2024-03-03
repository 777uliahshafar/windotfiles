# Function to Aliases current direcotry
function nvimconfig { set-location "$env:LOCALAPPDATA\nvim" }
function getchildtex { dir .\* -include ('*.tex', '*.bib') -recurse }
function obsidian
{
    nvim -c "ObsidianSearch"
}

function nvimalias
{
    cd '~/.config/powershell'
    & 'nvim' '.\aliases.ps1'
}

function vimmyhelp
{
    cd '~/vim-myhelp/doc'
    & 'nvim' '.\mycheat.txt'
}


function statistika
{
    cd 'D:\knstatistika'
    & 'nvim' '.\main.tex'
}

function interviewbpi
{
    cd 'D:\interviewbpi'
    & 'nvim' '.\interview.tex'
}

function microteaching
{
    cd 'D:\microteach'
    & 'nvim' '.\microteach.tex'
}

# Alias
Set-Alias v nvim
Set-Alias ll getchildtex
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias nc nvimconfig
Set-Alias na nvimalias
Set-Alias nvc vimmyhelp
Set-Alias ww obsidian

# Set-Alias phd phdjournal
Set-Alias sta statistika
Set-Alias int interviewbpi

Set-Alias mt microteaching


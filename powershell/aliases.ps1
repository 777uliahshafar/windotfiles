# Function to Aliases current direcotry
function nvimconfig { set-location "$env:LOCALAPPDATA\nvim" }
function neorgnotes
{
    nvim -c "Neorg workspace main"
}

function phdjournal
{
    cd '~/Documents/phdjournal/'
    & 'nvim' '.\phdjournal.tex'
}


# Alias
Set-Alias v nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias nc nvimconfig
Set-Alias jot neorgnotes

Set-Alias phd phdjournal

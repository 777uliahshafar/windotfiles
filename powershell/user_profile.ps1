function Run-Step([string] $Description, [ScriptBlock]$script)
{
  Write-Host  -NoNewline "Loading " $Description.PadRight(20)
  & $script
  Write-Host "`u{2705}" # checkmark emoji
}

$light = Start-ThreadJob {
Import-Module -Name z
Import-Module posh-git
}

$PSReadLine = Start-ThreadJob {
Import-Module PSReadLine
}

$PSFzf = Start-ThreadJob {
Import-Module PSFzf
}

Run-Step "oh-my-posh" {
$omp_config = Join-Path $PSScriptRoot ".\jondjones.omp.json"
oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression
}

Run-Step "terminal-icons" {
Import-Module -Name Terminal-Icons
}

Receive-Job $PSReadLine -Wait -AutoRemoveJob
Receive-Job $PSFzf -Wait -AutoRemoveJob
Receive-Job $light -Wait -AutoRemoveJob

# Settings

$env:POSH_GIT_ENABLED = $true # Posh git

Set-PSReadLineOption -EditMode Windows #PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Function AcceptSuggestion -Key 'Ctrl+Spacebar'
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward


Set-PSReadlineOption -Color @{
    "Command"          = [ConsoleColor]::Green
    "Parameter"        = [ConsoleColor]::Gray
    "Operator"         = [ConsoleColor]::Magenta
    "Variable"         = [ConsoleColor]::Yellow
    "String"           = [ConsoleColor]::Yellow
    "Number"           = [ConsoleColor]::Yellow
    "Type"             = [ConsoleColor]::Cyan
    "Comment"          = [ConsoleColor]::DarkCyan
    "InlinePrediction" = '#70A99F'
  }


Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r' #Psfzf


# Function to Aliases current direcotry
function nvimconfig { set-location "$env:LOCALAPPDATA\nvim" }
function academic
{
    cd 'C:\Users\ul\notes\aca'
    & 'nvim' '.\index.norg'
}
function architecture
{
    cd 'C:\Users\ul\notes\archi'
    & 'nvim' '.\index.norg'
}
function phdjournal
{
    cd '~/Documents/phdjournal/'
    & 'nvim' '.\phdjournal.tex'
}
function neorgnotes
{
    nvim -c "Neorg workspace main"
}


# Alias
Set-Alias v nvim
Set-Alias ll ls
Set-Alias g git
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'


Set-Alias nc nvimconfig
Set-Alias aca academic
Set-Alias arc architecture
Set-Alias phd phdjournal
Set-Alias jot neorgnotes

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

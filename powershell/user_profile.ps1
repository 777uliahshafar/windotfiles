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

# Chat gpt.nvim
$OPENAI_API_KEY = Get-Content C:\Users\uliah\.config\powershell\chatgptkey.txt

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

# load Aliases
. "$PSScriptRoot\aliases.ps1"

function aliases
{
    Get-Content $PSScriptRoot\aliases.ps1 | Select-Object -Index (180..210)
}

function magickaliases
{
    Get-Content $PSScriptRoot\aliases.ps1 | Select-Object -Index (195..215)
}

function projectaliases
{
    Get-Content $PSScriptRoot\aliases.ps1 | Select-Object -Index (225..240)
}

function windowsshortcut
{
    Get-Content $PSScriptRoot\aliases.ps1 | Select-Object -Index (240..270)
}

Set-Alias aa aliases
Set-Alias am magickaliases
Set-Alias ap projectaliases
Set-Alias aw windowsshortcut


# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

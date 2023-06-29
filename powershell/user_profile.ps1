function Run-Step([string] $Description, [ScriptBlock]$script)
{
  Write-Host  -NoNewline "Loading " $Description.PadRight(20)
  & $script
  Write-Host "`u{2705}" # checkmark emoji
}

$light = Start-ThreadJob {
Import-Module -Name z
Import-Module posh-git
$env:POSH_GIT_ENABLED = $true
}


$PSReadLine = Start-ThreadJob {
Import-Module PSReadLine
Set-PSReadLineOption -EditMode Windows
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
}

$PSFzf = Start-ThreadJob {
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
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

# Alias 
Set-Alias v nvim
Set-Alias ll ls
Set-Alias g git 
Set-Alias grep findstr
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

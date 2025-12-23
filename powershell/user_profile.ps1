function Run-Step([string] $Description, [ScriptBlock]$script)
{
    Write-Host  -NoNewline "Loading " $Description.PadRight(20)
    & $script
    Write-Host "`u{2705}" # checkmark emoji
}
Write-Host "Shortcuts: " -NoNewline -F Cyan
@{"^f"="find"; "^r"="cmd"; "z"="go to"}.GetEnumerator() | ForEach-Object {
    Write-Host "$($_.Key)" -NoNewline -F Yellow
    Write-Host ":$($_.Value) | " -NoNewline -F Gray
}
Write-Host ""

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

# load Aliases
. "$PSScriptRoot\aliases.ps1"

function Show-Aliases {
    param(
        [int]$Start=231,
        [int]$End=277
    )

    $file = Join-Path $PSScriptRoot 'aliases.ps1'

    Get-Content $file |
        Select-Object -Index (($Start - 1)..($End - 1))
}

Set-Alias sa Show-Aliases

# Utilities
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# VS Code Settings
1. Add the configuration vscode to user setting.json. Basically, all the setting are synced to your github account.

1. The path of powershell in vscode located in settings by searching it with terminal.external.windows.

# Powershell Configuration
1. install winget, windows terminal, powershell without microsoft store Link: https://christitus.com/installing-appx-without-msstore/.

1. Install nerdfont for icon supporting.

1. Set windows terminal to use nerdfont font and powershell as default shell. This can be edited in json file of windows terminal.

1. Install Scoop.

``` iwr -useb get.scoop.sh | iex ```

1. Install nvm, fzf and neovim (if necessary) with scoop.

1. Make user profile and set aliases

```
mkdir .config\powershell\
code .config\powershell\user_profile.ps1
all configuration should be added, modified and reused here
```

load the configuration profile to original profile.
```
code $PROFILE.CurrentUserCurrentHost
add a line: 
.env:USERPROFILE\.config\powershell\user_profile.ps1
```
1. install git and Github.cli with winget
```
winget install -e --id Git.Git
winget install Github.cli --source winget
```
after that, you can connect to your github account using ssh

1. Install Oh-my-posh with winget, the configuration should be already added in your profile.

1. Install modules of powershell :
- posh-git = install-Module -Name z -Force
- terminal icon = Install-Module -Name Terminal-Icons -Repository PSGallery
- z = install-Module -Name z -Force
- PSReadLine = Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
- PSFzf = Install-Module -Name PSFzf -Scope CurrentUser -Force

# Latex configuration
All configuration is already add in user setting .json. 

## Synctex
go to https://github.com/James-Yu/LaTeX-Workshop/wiki/View for pdfviewer reference.

- current viewer is sumatra pdf
add this line to sumatra setting.txt
```
InverseSearchCmdLine = "C:\Users\ulil\AppData\Local\Programs\Microsoft VS Code\Code.exe" "C:\Users\ulil\AppData\Local\Programs\Microsoft VS Code\resources\app\out\cli.js" --ms-enable-electron-run-as-node -r -g "%f:%l"
EnableTeXEnhancements = true
```

- these color changes also beneficial
```
BackgroundColor = #F0F0C0
TextColor = #000000
SelectionColor = #6C6F93
```

- Input zoom level percentage that fit your text, you what percentage that suit your need in menu bar zoom > custom zoom.

```
ZoomLevels = 
```










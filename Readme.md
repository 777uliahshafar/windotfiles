# Common Installation 
1. windows terminal (available)
1. powershell (available)
1. winget (available), scoop `iwr -useb get.scoop.sh | iex`, chocolatey
1. git `winget install -e --id Git.Git`
    - Set up git config --global (if necessary)
    - Connect github with ssh.
1. neovim `scoop install neovim`.
    - create `nvim` dir. in `cd $env:LOCALAPPDATA && mkdir nvim`
    - place your config (init.lua) inside nvim folder. 

PS: available on windows 11


# Windows Terminal config
1. Change the font to  Hack or CaskadiaCove Nerd Font Mono [font download](https://www.nerdfonts.com/font-downloads)
1. Place your config (terminal.json) to windows terminal config (setting.json)
1. Setting windows terminal appearance (font, transparency)

# Powershell Installation
1. oh-my-posh `scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json`
1. PSReadLine `Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck`
1. posh-git `Install-Module posh-git -Scope CurrentUser`
1. terminal-icons `Install-Module -Name Terminal-Icons -Repository PSGallery`
    - [link](https://gist.github.com/markwragg/6301bfcd56ce86c3de2bd7e2f09a8839)
1. z `install-Module -Name z -Force`
1. PSFzf `scoop install fzf  && Install-Module -Name PSFzf -Scope CurrentUser -Force`.


# Powershell Config
1. Check the availability powershell profile `Test-Path $PROFILE`, false means it is not exist
1. Create powershell profile `New-Item -Type file -Path $PROFILE -Force`.
1. Edit the profile `nvim  $PROFILE`. 
1. Symlink it to your own config. Type `. $env:USERPROFILE\.config\powershell\user_profile.ps1` inside the profile (optional)





1. Install nerdfont for icon supporting.

1. Set windows terminal to use nerdfont font and powershell as default shell. This can be edited in json file of windows terminal.

1. Install Scoop.


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










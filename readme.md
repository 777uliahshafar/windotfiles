# Windows update disable
- Run > services.msc > windowsupdate properties > disable 
- Run > import registry / go to Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU > create dword 32bit named NoAutoUpdate value 1.
# Common Installation

1. C++ `vc_redist.x64.exe`
1. windows terminal (available)
1. powershell (available)
1. winget (available/msixbundlegithubrepo), scoop `iwr -useb get.scoop.sh | iex`, chocolatey
1. git `winget install -e --id Git.Git`
    - Set up git config --global (if necessary)
    - Connect github with ssh.
1. neovim `scoop install neovim`.

PS: available on windows 11
change the executing policy `Set-ExecutionPolicy -Scope CurrentUser` > `RemoteSigned`

# Clone Config

1. Clone this in the home directory `cd`
1. `git clone git@github.com:777uliahshafar/windotfiles.git .config`

# Windows Terminal config

1. Change default profile in startup.
1. Change the font to Inconsolata Nerd Font Mono Medium 15pt [font download](https://www.nerdfonts.com/font-downloads)
1. Place your config (terminal.json) to windows terminal config (setting.json)
1. Setting windows terminal appearance (font, transparency) and default.
1. Enable `Use ... text rendering (Atlas engine)` on Rendering for inverted color cursor.

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


# Latex config

1. Strawberry Perl [link](https://strawberryperl.com/) latex on nvim.
2. Miktek, latex distribution [link](https://miktex.org/download). Package installation on the fly is much better. Check update on miktex console after installation, latex on nvim.
3. SumatraPDF, enable all the options on options menu, latex on nvim.
4. Add SumatraPDF parent directories of the executable to your `PATH environment variable` see [link](https://www.wikihow.com/Change-the-PATH-Environment-Variable-on-Windows), open `edit the system environment variables` → on Advanced System properties tab click environment variables → click path then click edit → then add this `C:\Users\ul\AppData\Local\SumatraPDF\`.
5. Zotero, BetterBibtex (synchronous bibliography),
- Change citation key in Tools → Preferences → BetterBibtex → Citation Keys → Citation key format:
```
[auth:lower][year]
```
- Change item format to `Better Bibtex` in Tools → Preferences → Exports → Item Format.
- Omit abstract,file, language from export bib in Tools → Preferences → BetterBibtex → Open Better Bibtex Preferences → Exports → Fields → Fields to omit from export:
```
abstract,file,language
```
6. Cimbali/pympress (dual-head presentation of PDF slides) like SplitShow.`winget install pympress`
7. Add some custom packages of latex to TEXMF root directory, such as [helpers4ht](https://github.com/michal-h21/helpers4ht).
- Register the TEXMF root directory `~/.config/mytexmf` in Miktex Console → Settings → Directories → Click Add icon, see [link](https://miktex.org/howto/miktex-console).
8. textcount, Perl script for counting word `texcount -h` to install it or find it (the package) on miktex console.
  - `texcount -sum -total .\filename.tex` to show wordcount.
  - put `%TC:group comment 0 0` before document environment.

 

# Windows config
  1. Windows OEM original with sunrise theme.
  2. Import all the registry from `Google Drive > Textediting`.
  3. Turn off the help improve battery by optimizing the content shown and brightness.
  4. Disable peek in `sysdm.cpl` for classic alt tab.
  5. Use white (light mode) background taskbar.

  6. Adding tag handler for unsupported file.
  - Install [Dijji/FileMeta]{https://github.com/Dijji/FileMeta}
  - Download the .msi file, then double click it.
  - [How-to]{https://www.thewindowsclub.com/enable-tags-for-unsupported-files-windows}
  7. Calibrate the display color if necessary.
  8. VGA driver from intel solve the adjusting brightness

## Required windows application\
  - Sumatrapdf for compilation viewer
  - Microsfot edge for default pdf viewer
  - Printer driver
  - Spotify
  - Google Driver
  - Authy
  - 7 Zip
  - Logi options+ (change strained button functions)




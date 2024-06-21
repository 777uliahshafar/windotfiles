# Windows update disable
- Run > services.msc > windowsupdate properties > disable
- Run > import registry / go to Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU > create dword 32bit named NoAutoUpdate value 1.

# Common Installation
1. Change the executing policy `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser` for installation permission, required by scoop.
1. C++ `vc_redist.x64.exe`
1. windows terminal (available)
1. powershell (available)
1. winget (available/msixbundlegithubrepo), scoop `iwr -useb get.scoop.sh | iex`, chocolatey `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))` (run as an admin powershell not cmd).
1. git `winget install -e --id Git.Git`
    - Set up git config --global (if necessary)
    - Connect github with ssh.
1. neovim `scoop install neovim`.

# Clone Config

1. Clone this in the home directory `cd`
1. `git clone git@github.com:777uliahshafar/windotfiles.git .config`

# Windows Terminal config

1. Change default profile in startup.
1. Change the font to Inconsolata Nerd Font Mono Medium 15pt [font download](https://www.nerdfonts.com/font-downloads). Nerd font can provide icon for Terminal-Icons.
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
1. PSFzf `scoop install fzf  && Install-Module -Name PSFzf -Scope CurrentUser -Force`. Another way of install `winget install fzf`.
1. ChatGPT.nvim, adjust the API key in powershell folder. It has alread loaded in powershell config.
1. Pandoc, either installing from msi installer or winget. `winget install --source winget --exact --id JohnMacFarlane.Pandoc`
1. Pandoc latex template, convert md to pdf with template. Move the template eisvogel.latex in `C:\Users\USERNAME\AppData\Roaming\pandoc\templates\`, create one if there is no path/folder. Source `https://github.com/Wandmalfarbe/pandoc-latex-template`

# Powershell Config
1. Check the availability powershell profile `Test-Path $PROFILE`, false means it is not exist
1. Create powershell profile `New-Item -Type file -Path $PROFILE -Force`.
1. Edit the profile `nvim  $PROFILE`.
1. Symlink it to your own config. Type `. $env:USERPROFILE\.config\powershell\user_profile.ps1` inside the profile (optional)
1. Install nerdfont for icon supporting.


# Latex config

1. Strawberry Perl [link](https://strawberryperl.com/) latex on nvim.
2. Miktek, latex distribution [link](https://miktex.org/download). Package installation on the fly is much better. Check update on miktex console after installation, latex on nvim.
3. SumatraPDF, enable all the options on options menu, latex on nvim.
4. Add SumatraPDF parent directories of the executable to your `PATH environment variable` see [link](https://www.wikihow.com/Change-the-PATH-Environment-Variable-on-Windows), open `edit the system environment variables` → on Advanced System properties tab click environment variables → click path then click edit → then add this for local installation  `C:\Users\ul\AppData\Local\SumatraPDF\` or this for global installation `C:\Program Files\SumatraPDF`. or
5. Download and Install sioyek (either clone or installer). Add Sioyek parent directories of the executable to your `PATH environment variable` see [link](https://www.wikihow.com/Change-the-PATH-Environment-Variable-on-Windows), open `edit the system environment variables` → on Advanced System properties tab click environment variables → click path then click edit → then add this for file location such as `C:\Program Files\Sioyek`  or anywhere Sioyek is located.
6. Zotero, Add-ons: BetterBibtex (synchronous bibliography), zotfile, BetterNotes
- Change item format to `Better Bibtex` in Edit → Preferences → Exports → Item Format.
- Change citation key in Edit → Preferences → BetterBibtex → Citation Keys → Citation key format:
```
[auth:lower][year]
```
- Omit (abstract,file, language) from export bib in Tools → Preferences → BetterBibtex → Open Better Bibtex Preferences → Exports → Fields → Fields to omit from export:
```
abstract,file,language
```
6. Zotero dark theme: go to `C:\Users\User_name\AppData\Roaming\Zotero\Zotero\Profiles\user_profile.default\` → Create folder `chrome` → paste `userChrome.css`
6. Dark theme in the Note Editor :
- Go to Preferences -> Advanced -> Config Editor
- Select "I accept the risks!"
- Search extensions.zotero.note.css and double-click it
- Insert the string in the `noteEditor.css` file
- Click "OK" or close the dialog box
6. Renaming propertis zotfile : {%t-}{%a-}{%y}
6. Cimbali/pympress (dual-head presentation of PDF slides) like SplitShow.`winget install pympress`
7. Add some custom packages of latex to TEXMF root directory, such as [helpers4ht](https://github.com/michal-h21/helpers4ht).
- Register the TEXMF root directory `~/.config/mytexmf` in Miktex Console → Settings → Directories → Click Add icon, see [link](https://miktex.org/howto/miktex-console).
8. textcount, Perl script for counting word `texcount -h` to install it or find it (the package) on miktex console.
  - `texcount -sum -total .\filename.tex` to show wordcount.
  - put `%TC:group comment 0 0` before document environment.



# Windows config
  1. sunrise theme windows.
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
  9. XYplorer.

## Xyplorer config
- Active full row select : Tools > Customize List > Full Row Select.
- Important toolbar : Thumbnail view, Show hidden items, Show tree, floating preview.
- Config
- Configuration | Other | Shell Integration | Default File Manager | [x] XYplorer in shell context menu.
- Configuration | Other | Shell Integration | Default File Manager | [x] XYplorer is default file manager.
- Configuration | Other | Shell Integration | Show the 64bit context menu

# Required windows application
  - Sioyek windows zip release for compilation viewer (locate it on program file for easy tracking)
  - xyplorer
  - Microsfot edge for default pdf viewer
  - Printer driver
  - Spotify
  - Google Driver
  - Authy
  - 7 Zip




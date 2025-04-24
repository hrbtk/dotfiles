# Setup Git Bash for windows

## 0 Downloads

### 0.1 Nerd font

Download and install nerd font from [here](https://github.com/ryanoasis/nerd-fonts)

### 0.2 Binaries

Install _micro_, _helix_, _eza_, _bat_, _fzf_ and _starship_ using _winget_ from PowerShell

```shell
winget install zyedidia.micro
winget install Helix.Helix
winget install sharkdp.bat
winget install eza-community.eza
winget install starship
winget install fzf
```
### 0.3 Clone fzf for git

```
git clone https://github.com/junegunn/fzf-git.sh ~/.config/git/fzf-git.sh
```

## 1 Change Windows Terminal settings.json

### 1.1 Add colorschemes

<details>
<summary>Tokyo Night</summary>

```json
{
    "background": "#1A1B2C",
    "black": "#414868",
    "blue": "#7AA2F7",
    "brightBlack": "#414868",
    "brightBlue": "#7AA2F7",
    "brightCyan": "#7DCFFF",
    "brightGreen": "#73DACA",
    "brightPurple": "#BB9AF7",
    "brightRed": "#F7768E",
    "brightWhite": "#C0CAF5",
    "brightYellow": "#E0AF68",
    "cursorColor": "#C0CAF5",
    "cyan": "#7DCFFF",
    "foreground": "#A9B1DC",
    "green": "#73DACA",
    "name": "Tokyo Night",
    "purple": "#BB9AF7",
    "red": "#F7768E",
    "selectionBackground": "#28344A",
    "white": "#C0CAF5",
    "yellow": "#E0AF68"
},
{
    "background": "#D5D6DB",
    "black": "#0F0F14",
    "blue": "#34548A",
    "brightBlack": "#0F0F14",
    "brightBlue": "#34548A",
    "brightCyan": "#0F4B6E",
    "brightGreen": "#33635C",
    "brightPurple": "#5A4A78",
    "brightRed": "#8C4351",
    "brightWhite": "#343B58",
    "brightYellow": "#8F5815",
    "cursorColor": "#FFFFFF",
    "cyan": "#0F4B6E",
    "foreground": "#343B58",
    "green": "#33635C",
    "name": "Tokyo Night Light",
    "purple": "#5A4A78",
    "red": "#8C4351",
    "selectionBackground": "#FFFFFF",
    "white": "#343B58",
    "yellow": "#8F5815"
},
{
    "background": "#24283B",
    "black": "#414868",
    "blue": "#7AA2F7",
    "brightBlack": "#414868",
    "brightBlue": "#7AA2F7",
    "brightCyan": "#7DCFFF",
    "brightGreen": "#73DACA",
    "brightPurple": "#BB9AF7",
    "brightRed": "#F7768E",
    "brightWhite": "#C0CAF5",
    "brightYellow": "#E0AF68",
    "cursorColor": "#C0CAF5",
    "cyan": "#7DCFFF",
    "foreground": "#A9B1DC",
    "green": "#73DACA",
    "name": "Tokyo Night Storm",
    "purple": "#BB9AF7",
    "red": "#F7768E",
    "selectionBackground": "#28344A",
    "white": "#C0CAF5",
    "yellow": "#E0AF68"
}
```

</details>


## 2 Change .bashrc

Copy .bashrc file to $HOME

## 3 git config

Add to ~/.gitconfig
```
[user]
  name =
  email =
[core]
  autocrlf = input
  longpaths = true  
```

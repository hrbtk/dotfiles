# Setup Git Bash for windows

## 0 Downloads

### 0.1 Nerd font
Download and install nerd font from [here](https://github.com/ryanoasis/nerd-fonts)

### 0.2 Binaries
Download [micro](https://github.com/zyedidia/micro/releases/latest), [exa](https://github.com/eza-community/eza/releases/latest) and [starship](https://github.com/starship/starship/releases/latest) binaries and place them under `C:\Program Files\Git\usr\bin\`

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

### 1.2 Add new Profile with GUI and add colorScheme, font, icon and startingDirectory
```json
{
    "colorScheme": "Tokyo Night",
    "commandline": "\"%PROGRAMFILES%\\Git\\usr\\bin\\bash.exe\" -i -l",
    "font": 
    {
        "face": "MesloLGS Nerd Font",
        "size": 16.0
    },
    "guid": "{2faca2e0-9dc5-4fd5-84b7-c35e4e72fbd3}",
    "hidden": false,
    "icon": "C:\\Program Files\\Git\\mingw64\\share\\git\\git-for-windows.ico",
    "name": "MyGitBash",
    "startingDirectory": "C:\\"
}
```

## 2 Change .bashrc

### 2.1 Cretate .bashrc
`touch ~/.bashrc`

### 2.2 Add Aliases
```
# Aliases
alias ls='eza --color=always'
alias ll='eza -alh --header --color=always --icons=always --git --group-directories-first'
alias lt='eza -alh --header --color=always --icons=always --tree --group-directories-first'
alias gs='git status'
alias gaa='git add .'
alias gti='git'
alias e='micro'
alias se='sudo micro'
alias grep='grep --color=auto'
alias df='df -h'
alias free='free -h'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
```

### 2.3 Install fzf
Install fzf using [git](https://github.com/junegunn/fzf?tab=readme-ov-file#using-git)

### 2.4 Add Starship prompt
```
# starship
eval "$(starship init bash)"
```



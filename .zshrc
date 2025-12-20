#######################################################
# Plugins
#######################################################

# Install zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname "$ZINIT_HOME")"
[ ! -d "$ZINIT_HOME/.git" ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Add plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light Aloxaf/fzf-tab


#######################################################
# ZSH Configuration
#######################################################

# History
HISTSIZE=10000
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt append_history
setopt share_history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Keybindings
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey -v

# <Ctrl-e> to edit command-line in EDITOR
autoload -Uz edit-command-line && zle -N edit-command-line && bindkey "^e" edit-command-line

# Completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview "ls --color $realpath"

autoload -Uz compinit && compinit

zinit cdreplay -q


#######################################################
# Variables
#######################################################

export DEVDIR=${HOME}/dev
export HELIX_RUNTIME="$DEVDIR/helix/runtime"
export LSP_PATH="$DEVDIR/lua-language-server/bin:$DEVDIR/jdt-language-server/bin"
export PATH="$PATH:$HOME/.local/bin:$HOME/.scripts:/usr/local/go/bin:$LSP_PATH"
export EDITOR=hx
export SUDO_EDITOR=hx
export VISUAL=hx

#######################################################
# Aliases
#######################################################

alias grep='grep --color=auto'
alias df='df -h'
alias free='free -h'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmdir='rmdir -v'
alias cal='cal -m'

# Alias for git
alias gs='git status'
alias gaa='git add .'
alias gti='git'
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"

# Alias for eza
if [[ -x "$(command -v eza)" ]]; then
  alias ls='eza --icons=always --color=always'
  alias ll='eza -alh --header --icons=always --color=always --git --group-directories-first'
  alias lt='eza -alh --header --icons=always --color=always --tree --group-directories-first'
else
  alias ls='ls --color=always'
  alias ll='ls -alh --color=always'
  if [[ -x "$(command -v tree)" ]]; then
    alias lt='tree -a'
  fi
fi

# Alias for micro
# if [[ -x "$(command -v micro)" ]]; then
#   alias e='micro'
#   alias se='sudo micro'
# fi

# Alias for lazydocker
if [[ -x "$(command -v lazydocker)" ]]; then
  alias lzd='lazydocker'
fi

# Alias for lazygit
if [[ -x "$(command -v lazygit)" ]]; then
  alias lzgit='lazygit'
fi

# Alias for Neovim
alias clnvim='rm -rf mv ~/.cache/nvim ~/.local/share/nvim ~/.local/state/nvim'

if [ -f ~/.config/nvim-minimal/init.lua ]; then
  alias nvims="NVIM_APPNAME=nvim-minimal nvim"
fi

if [ -f ~/.config/nvim-minimax/init.lua ]; then
  alias mininvim="NVIM_APPNAME=nvim-minimax nvim"
fi

# Get local IP addresses
if [[ -x "$(command -v ip)" ]]; then
    alias iplocal="ip -br -c a"
else
    alias iplocal="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
fi


#######################################################
# FZF Setup
#######################################################

# Shell integration
eval "$(fzf --zsh)"

# fzf for git
if [ -f "$HOME/fzf-git.sh/fzf-git.sh" ]; then
    source "$HOME/fzf-git.sh/fzf-git.sh"
fi


#######################################################
# Fetch
#######################################################
if [[ $(command -v afetch) ]]; then
    afetch
    printf "\n"
elif [[ $(command -v fastfetch) ]]; then
    fastfetch
elif [[ $(command -v neofetch) ]]; then
    neofetch
fi

#######################################################
# Prompt
#######################################################


if [[ $(command -v starship) ]]; then
  eval "$(starship init zsh)"
fi


#######################################################
# Other
#######################################################

# Taskfile

if [[ $(command -v task) ]]; then
  eval "$(task --completion zsh)"
fi

# Yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

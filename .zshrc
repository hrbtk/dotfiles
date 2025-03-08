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

export PATH="$PATH:/home/herbatka/.local/bin:/home/herbatka/.scripts:/usr/local/go/bin"
export EDITOR=hx
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
if [[ -x "$(command -v micro)" ]]; then
  alias e='micro'
  alias se='sudo micro'
fi

# Alias for lazydocker
if [[ -x "$(command -v lazydocker)" ]]; then
  alias lzd='lazydocker'
fi

# Alias for lazygit
if [[ -x "$(command -v lazygit)" ]]; then
  alias lzgit='lazygit'
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
source "$HOME/fzf-git.sh/fzf-git.sh"

# show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

# export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
# export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
# export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"


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
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

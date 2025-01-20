
#######################################################
# Plugins
#######################################################

source "$HOME/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
# source "$HOME/.config/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"


#######################################################
# Variables
#######################################################

export PATH="$PATH:/home/herbatka/.local/bin:/home/herbatka/.scripts:/usr/local/go/bin"
export EDITOR=helix
export VISUAL=helix


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
# ZSH Configuration
#######################################################

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
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
autoload -U +X compinit && compinit


#######################################################
# FZF Setup
#######################################################

# fzf (will be added automaticaly during installation)
# eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf for git
source ~/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"


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

eval "$(starship init zsh)"


#######################################################
# Other
#######################################################

# Taskfile
eval "$(task --completion zsh)"

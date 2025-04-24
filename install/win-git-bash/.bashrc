#
# ~/.bashrc
#

#######################################################
# options
#######################################################

shopt -s autocd
shopt -s cdspell
shopt -s direxpand dirspell
shopt -s globstar
shopt -s cmdhist
shopt -s histappend histverify

HISTCONTROL=ignoreboth:erasedups
HISTIGNORE=?:??:history
HISTSIZE=99999
HISTFILESIZE=99999

PROMPT_COMMAND='history -a'

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
  alias ll='eza -alh --header --icons=always --color=always --group-directories-first'
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

# Get local IP addresses
if [[ -x "$(command -v ip)" ]]; then
    alias iplocal="ip -br -c a"
else
    alias iplocal="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"
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
# fzf
eval "$(fzf --bash)"
if [ -f ~/.config/git/fzf-git.sh/fzf-git.sh ]; then
  source ~/.config/git/fzf-git.sh/fzf-git.sh 
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

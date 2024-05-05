# Plugins
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
alias ls='eza --icons=always --color=always'
alias ll='eza -alh --header --icons=always --color=always --git --group-directories-first'
alias lt='eza -alh --header --icons=always --color=always --tree --group-directories-first'
alias gs='git status'
alias e='micro'
alias se='sudo micro'
alias grep='grep --color=auto'
alias df='df -h'
alias free='free -h'

# History
HISTFILE=~/.zsh_history
HISTSIZE=999
SAVEHIST=1000

setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# Prompt
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

# Set up fzf key bindings and fuzzy completion
# eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Fetch on startup
afetch

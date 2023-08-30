

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#Aliases
alias ll="exa -alh --color=always --git --group-directories-first"
alias lt="exa -Tal --level=3 --color=always  --group-directories-first"
alias micro="~/micro"
alias e="~/bin/micro"
alias se="sudo ~/bin/micro"

alias gs="git status"
alias gc="git commit"

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%F{yellow}[%b]%f '

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%F{green}%1~%f ${vcs_info_msg_0_}$ '

# Don't show duplicated lines in history
setopt HIST_FIND_NO_DUPS

# PROMPT='%F{cyan}%n%f : %F{green}%1~%f ${vcs_info_msg_0_}$ '

# export PS1="%F{cyan}%n%f : %F{green}%1~%f %# "
# old PS1: %n@%m %1~ %#

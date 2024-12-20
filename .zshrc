# Plugins
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/.config/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# export variables
export PATH="$PATH:/home/herbatka/.local/bin:/home/herbatka/.scripts"
export EDITOR=nvim
export VISUAL=nvim

# Aliases
alias ls='eza --icons=always --color=always'
alias ll='eza -alh --header --icons=always --color=always --git --group-directories-first'
alias lt='eza -alh --header --icons=always --color=always --tree --group-directories-first'
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
alias cal='cal -m'
alias lzd='lazydocker'
alias lgit='lazygit'

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

# Completions (commented out because of zsh-autocomplete plugin)
# autoload -Uz compinit && compinit 
autoload -U +X compinit && compinit

# fzf (will be added automaticaly during installation)
# eval "$(fzf --zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/fzf-git.sh/fzf-git.sh

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}


# Neovim switcher
alias nvim-lazy="NVIM_APPNAME=LazyVim nvim"
alias nvim-kick="NVIM_APPNAME=kickstartVim nvim"
alias nvim-chad="NVIM_APPNAME=DrewNvim nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"

# Fetch on startup
if [[ $(command -v afetch) ]]; then
    afetch
    printf "\n"
elif [[ $(command -v fastfetch) ]]; then
    fastfetch
elif [[ $(command -v neofetch) ]]; then
    neofetch
fi

# Prompt
# autoload -Uz vcs_info
# precmd() { vcs_info }
# zstyle ':vcs_info:git:*' formats '%b '
# setopt PROMPT_SUBST
# PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

# starship prompt
eval "$(starship init zsh)"

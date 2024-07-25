# Plugins
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/.config/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# export variables
export PATH="$PATH:/home/herbatka/.local/bin"
export EDITOR=micro
export VISUAL=micro

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

function nvims() {
  items=("default" "kickstartVim" "LazyVim" "DrewNvim" "AstroNvim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}


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

# yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Extract function
function extract {
 if [ $# -eq 0 ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|.zlib|.cso|.zst>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 fi
    for n in "$@"; do
        if [ ! -f "$n" ]; then
            echo "'$n' - file doesn't exist"
            return 1
        fi

        case "${n%,}" in
          *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                       tar xvf "$n"       ;;
          *.lzma)      unlzma ./"$n"      ;;
          *.bz2)       bunzip2 ./"$n"     ;;
          *.cbr|*.rar) unrar x -ad ./"$n" ;;
          *.gz)        gunzip ./"$n"      ;;
          *.cbz|*.epub|*.zip) unzip ./"$n"   ;;
          *.z)         uncompress ./"$n"  ;;
          *.7z|*.apk|*.arj|*.cab|*.cb7|*.chm|*.deb|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar|*.vhd)
                       7z x ./"$n"        ;;
          *.xz)        unxz ./"$n"        ;;
          *.exe)       cabextract ./"$n"  ;;
          *.cpio)      cpio -id < ./"$n"  ;;
          *.cba|*.ace) unace x ./"$n"     ;;
          *.zpaq)      zpaq x ./"$n"      ;;
          *.arc)       arc e ./"$n"       ;;
          *.cso)       ciso 0 ./"$n" ./"$n.iso" && \
                            extract "$n.iso" && \rm -f "$n" ;;
          *.zlib)      zlib-flate -uncompress < ./"$n" > ./"$n.tmp" && \
                            mv ./"$n.tmp" ./"${n%.*zlib}" && rm -f "$n"   ;;
          *.dmg)
                      hdiutil mount ./"$n" -mountpoint "./$n.mounted" ;;
          *.tar.zst)  tar -I zstd -xvf ./"$n"  ;;
          *.zst)      zstd -d ./"$n"  ;;
          *)
                      echo "extract: '$n' - unknown archive method"
                      return 1
                      ;;
        esac
    done
}

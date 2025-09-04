#!/usr/bin/env bash
set -euo pipefail

# Colors
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

nvim_repo="https://github.com/neovim/neovim"
nvim_dir="${DEVDIR:-}/neovim"

error() {
    printf "%s[ERROR]%s %s\n" "$RED" "$RESET" "$1" >&2
    exit 1
}

info() {
    printf "%s[INFO]%s %s\n" "$GREEN" "$RESET" "$1"
}

warn() {
    printf "%s[WARN]%s %s\n" "$YELLOW" "$RESET" "$1"
}

check_deps() {
    local deps=(git cmake make ninja)
    local missing=()

    for cmd in "${deps[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            missing+=("$cmd")
        fi
    done

    if [[ ${#missing[@]} -ne 0 ]]; then
        error "Missing required tools: ${missing[*]}"
    else
        info "All required dependencies are installed."
    fi
}

clone_neovim() {
    info "Cloning Neovim..."
    git clone "$nvim_repo" "$nvim_dir"
}

install_neovim() {
    info "Building Neovim..."
    pushd "$nvim_dir" >/dev/null
    git pull 
    make CMAKE_BUILD_TYPE=Release
    sudo make install
    popd >/dev/null
    info "Neovim installed successfully!"
}

main() {
    [[ -z "${DEVDIR:-}" ]] && error "DEVDIR is not set."
    check_deps

    if [[ ! -d "$nvim_dir" ]]; then
        clone_neovim
    fi

    install_neovim
}

main "$@"

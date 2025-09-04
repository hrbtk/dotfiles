#!/usr/bin/env bash
set -euo pipefail

# Colors
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

helix_repo="https://github.com/helix-editor/helix"
helix_dir="${DEVDIR:-}/helix"

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
    local deps=(git rustup gcc)
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

clone_helix() {
    info "Cloning Helix..."
    git clone "$helix_repo" "$helix_dir"
}

install_helix() {
    info "Building Helix..."
    pushd "$helix_dir" >/dev/null
	git pull
	cargo install --path helix-term --locked
    popd >/dev/null
    info "Helix installed successfully!"
}

main() {
    [[ -z "${HELIX_RUNTIME:-}" ]] && error "HELIX_RUNTIME is not set."
    check_deps

    if [[ ! -d "$helix_dir" ]]; then
        clone_helix
    fi

    install_helix
}

main "$@"

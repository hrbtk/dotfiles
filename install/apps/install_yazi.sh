
#!/usr/bin/env bash
set -euo pipefail

# Colors
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

yazi_repo="https://github.com/sxyazi/yazi.git"
yazi_dir="${DEVDIR:-}/yazi"

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
    local deps=(git gcc make rustup)
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

clone_yazi() {
    info "Cloning Yazi..."
    git clone "$yazi_repo" "$yazi_dir"
}

install_yazi() {
    info "Building Yazi..."
    pushd "$yazi_dir" >/dev/null
    git pull 
	cargo build --release --locked
	sudo mv target/release/yazi target/release/ya /usr/local/bin/
    popd >/dev/null
    info "Yazi installed successfully!"
}

main() {
    [[ -z "${DEVDIR:-}" ]] && error "DEVDIR is not set."
    check_deps

    if [[ ! -d "$yazi_dir" ]]; then
        clone_yazi
    fi

    install_yazi
}

main "$@"

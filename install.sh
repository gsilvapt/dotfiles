#!/usr/bin/bash

DEB_PKGS=(
    "git"
    "zsh"
    "htop"
    "neovim"
    "python3-neovim"
    "build-essential"
    "cmake"
    "python3-dev"
    "i3"
    "i3status"
    "dmenu"
    "feh"
)

RH_PKGS=(
    "git"
    "zsh"
    "neovim"
    "python3-neovim"
    "@development-tools"
    "i3"
    "i3status"
    "dmenu"
    "feh"
)

# macOS-only packages. AeroSpace ships via a Homebrew cask tap.
BREW_CASKS=(
    "nikitabobko/tap/aerospace"
)


declare -A DOTFILES_MAP
DOTFILES_MAP["zed"]="$HOME/.zed"
DOTFILES_MAP["opencode/opencode.json"]="$HOME/.config/opencode/opencode.json"
DOTFILES_MAP["claude/settings.json"]="$HOME/.claude/settings.json"
DOTFILES_MAP["skills"]="$HOME/.claude/skills"
DOTFILES_MAP["nvim"]="$HOME/.config/nvim"
DOTFILES_MAP["alacritty.toml"]="$HOME/.config/alacritty/alacritty.toml"
DOTFILES_MAP["zsh/rc"]="$HOME/.zshrc"
DOTFILES_MAP["zsh/env"]="$HOME/.zsh_env"
DOTFILES_MAP["zsh/aliases"]="$HOME/.zsh_aliases"
DOTFILES_MAP[".tmux.conf"]="$HOME/.tmux.conf"
DOTFILES_MAP[".gitconfig"]="$HOME/.gitconfig"
DOTFILES_MAP[".lynx.cfg"]="$HOME/.lynx.cfg"
DOTFILES_MAP[".lynx.lss"]="$HOME/.lynx.lss"
# AeroSpace config is version-controlled on every machine; only macOS
# actually consumes it, but keeping the symlink cross-platform is harmless
# and means the file stays in sync if you ever edit it from Linux.
DOTFILES_MAP[".aerospace.toml"]="$HOME/.aerospace.toml"
DOTFILES_MAP["scripts"]="$HOME/"


is_macos() {
    [[ "$(uname)" == "Darwin" ]]
}

# On Linux systems we also manage the i3wm config.
if ! is_macos; then
    DOTFILES_MAP["i3/config"]="$HOME/.config/i3/config"
    DOTFILES_MAP["i3/i3status"]="$HOME/.config/i3status/config"
fi

get_pkg_manager() {
    if command -v apt &> /dev/null; then
        echo "apt"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v brew &> /dev/null; then
        echo "brew"
    else
        echo ""
    fi
}

install_pkgs() {
    local skip=$1
    if $skip; then
        echo "skipping pkg installation as --skip-pkg-install was provided"
        return 0
    fi
    pkg_manager="$(get_pkg_manager)"
    echo "installing dependencies for ${pkg_manager}"
    case $pkg_manager in 
        "apt")
            sudo apt update -y && sudo apt install -y "${DEB_PKGS[@]}"
            return 0
            ;;
        "dnf")
            sudo dnf update -y && sudo dnf install -y "${RH_PKGS[@]}"
            return 0
            ;;
        "brew")
            # Casks need `--cask`; the tap prefix in BREW_CASKS triggers
            # `brew tap` implicitly on first install.
            brew install --cask "${BREW_CASKS[@]}"
            return 0
            ;;
        *)
            echo "failed to detect system's package manager: ${pkg_manager}"
            return 1
            ;;
    esac
}

create_symlinks() {
    for file in "${!DOTFILES_MAP[@]}"; do
        echo "creating symlink for $file at ${DOTFILES_MAP[$file]}"
        ln -s "$(pwd)/$file" "${DOTFILES_MAP[$file]}"
    done
}

main() {
    skip_pkgs=false
    while [[ "$1" != "" ]]; do
        case $1 in
            --skip-pkg-install)
                skip_pkgs=true
                ;;
            *)
                echo "unrecognized flag: only --skip-pkg-install is supported"
                exit 1
        esac
        shift
        done

    if ! install_pkgs $skip_pkgs; then
        exit $?
    fi

    echo "preparing environment to symlink dotfiles"
    mkdir -p "$HOME/.config/zed/"
    mkdir -p "$HOME/.config/opencode/"
    mkdir -p "$HOME/.claude/"
    mkdir -p "$HOME/.config/nvim/"
    mkdir -p "$HOME/.config/alacritty/"
    if ! is_macos; then
        mkdir -p "$HOME/.config/i3/"
        mkdir -p "$HOME/.config/i3status/"
    fi

    create_symlinks

    echo "Neovim will require installing LSPs to work properly"

    return 0
}

main "$@"

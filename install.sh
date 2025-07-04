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
)

RH_PKGS=(
    "git"
    "zsh"
    "neovim"
    "python3-neovim"
    "@development-tools"
)


declare -A DOTFILES_MAP
DOTFILES_MAP["nvim"]="$HOME/.config/nvim"
DOTFILES_MAP["alacritty.toml"]="$HOME/.config/alacritty/alacritty.toml"
DOTFILES_MAP[".zshrc"]="$HOME/.zshrc"
DOTFILES_MAP[".zsh_env"]="$HOME/.zsh_env"
DOTFILES_MAP[".zsh_aliases"]="$HOME/.zsh_aliases"
DOTFILES_MAP[".tmux.conf"]="$HOME/.tmux.conf"
DOTFILES_MAP[".gitconfig"]="$HOME/.gitconfig"
DOTFILES_MAP[".lynx.cfg"]="$HOME/.lynx.cfg"
DOTFILES_MAP[".lynx.lss"]="$HOME/.lynx.lss"


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
    mkdir -p "$HOME/.config/nvim/"
    mkdir -p "$HOME/.config/alacritty/"

    create_symlinks

    echo "Neovim will require installing LSPs to work properly"

    return 0
}

main "$@"

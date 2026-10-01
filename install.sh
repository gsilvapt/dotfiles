#!/usr/bin/env bash

DEB_PKGS=(
    "git"
    "git-delta"
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
    "git-delta"
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
    "git-delta"
    "neovim"
)


declare -A DOTFILES_MAP

DOTFILES_MAP["opencode/opencode.json"]="$HOME/.config/opencode/opencode.json"
DOTFILES_MAP["claude/settings.json"]="$HOME/.claude/settings.json"
DOTFILES_MAP["pi/settings.json"]="$HOME/.pi/agent/settings.json"
DOTFILES_MAP["nvim/*"]="$HOME/.config/nvim"
DOTFILES_MAP["ghostty.config"]="$HOME/.config/ghostty/config"
DOTFILES_MAP["zsh/rc"]="$HOME/.zshrc"
DOTFILES_MAP["zsh/env"]="$HOME/.zsh_env"
DOTFILES_MAP["zsh/aliases"]="$HOME/.zsh_aliases"
DOTFILES_MAP[".tmux.conf"]="$HOME/.tmux.conf"
DOTFILES_MAP[".gitconfig"]="$HOME/.gitconfig"
DOTFILES_MAP["lazygit.yml"]="$HOME/.config/lazygit/config.yml"
DOTFILES_MAP["scripts"]="$HOME/"


is_macos() {
    [[ "$(uname)" == "Darwin" ]]
}

# Environment-specific configs
if ! is_macos; then
    DOTFILES_MAP["i3/config"]="$HOME/.config/i3/config"
    DOTFILES_MAP["i3/i3status"]="$HOME/.config/i3status/config"

else; then
    DOTFILES_MAP[".aerospace.toml"]="$HOME/.aerospace.toml"
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

install_skills() {
    local skill
    local skill_name

    mkdir -p "$HOME/.agents/skills" "$HOME/.claude/skills"

    for skill in "$(pwd)"/skills/*; do
        if [[ ! -f "$skill/SKILL.md" && ! -f "$skill/skill.md" ]]; then
            continue
        fi

        skill_name="$(basename "$skill")"
        echo "creating symlink for $skill_name at $HOME/.agents/skills/$skill_name"
        ln -s "$skill" "$HOME/.agents/skills/$skill_name" || return 1

        echo "creating symlink for $skill_name at $HOME/.claude/skills/$skill_name"
        ln -s "$HOME/.agents/skills/$skill_name" \
            "$HOME/.claude/skills/$skill_name" || return 1
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
    mkdir -p "$HOME/.config/opencode/"
    mkdir -p "$HOME/.claude/"
    mkdir -p "$HOME/.pi/agent/"
    mkdir -p "$HOME/.config/nvim/"
    mkdir -p "$HOME/.config/ghostty/"
    mkdir -p "$HOME/.config/lazygit/"
    if ! is_macos; then
        mkdir -p "$HOME/.config/i3/"
        mkdir -p "$HOME/.config/i3status/"
    fi

    create_symlinks
    install_skills || return 1

    echo "Neovim will require installing LSPs to work properly"

    return 0
}

main "$@"

#!/usr/bin/env bash
set -e

# Get the directory where this script is located
DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Prompt for git config
echo ""
read -p "👤 Set up Git config? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    read -p "  Your name: " GIT_NAME
    read -p "  Your email: " GIT_EMAIL

    # Create gitconfig with user info
    cat > ~/.gitconfig << EOF
[user]
    name = $GIT_NAME
    email = $GIT_EMAIL

[include]
    path = $DOTFILES/git/gitconfig
EOF

    ln -sf "$DOTFILES/git/gitignore_global" ~/.gitignore_global
    ln -sf "$DOTFILES/git/tigrc" ~/.tigrc
fi

echo ""
echo "🔗 Linking dotfiles..."

ln -sf "$DOTFILES/shell/zshrc" ~/.zshrc

# Vim
ln -sf "$DOTFILES/vim/.vimrc" ~/.vimrc

# Ghostty terminal
echo ""
read -p "👻 Install Ghostty terminal and link config? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Install Ghostty via Homebrew cask
    if ! brew list --cask ghostty &>/dev/null; then
        echo "  Installing Ghostty..."
        brew install --cask ghostty
    fi

    # Link config
    mkdir -p ~/.config/ghostty
    ln -sf "$DOTFILES/config/ghostty/config" ~/.config/ghostty/config
    echo "  Ghostty config linked. Restart Ghostty to apply."

    # Install JetBrains Mono Nerd Font
    echo ""
    read -p "   Install JetBrains Mono Nerd Font? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        if ! brew list --cask font-jetbrains-mono-nerd-font &>/dev/null; then
            echo "  Installing JetBrains Mono Nerd Font..."
            brew install --cask font-jetbrains-mono-nerd-font
        else
            echo "  JetBrains Mono Nerd Font already installed."
        fi
    fi
fi

# VSCode Insiders settings
echo ""
read -p "💻 Install VSCode Insiders and link settings? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Install VSCode Insiders if not present
    if ! brew list --cask visual-studio-code@insiders &>/dev/null; then
        echo "  Installing VSCode Insiders..."
        brew install --cask visual-studio-code@insiders
    fi

    # Link settings
    mkdir -p ~/Library/Application\ Support/Code\ -\ Insiders/User
    ln -sf "$DOTFILES/config/vscode-insiders/settings.json" ~/Library/Application\ Support/Code\ -\ Insiders/User/settings.json
    echo "  VSCode Insiders settings linked. Reload VSCode Insiders to apply."
fi

# SSH config (ask first)
if [ ! -f ~/.ssh/config ]; then
    echo ""
    read -p "📡 Link SSH config template? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        mkdir -p ~/.ssh
        ln -sf "$DOTFILES/ssh/config" ~/.ssh/config
        chmod 600 ~/.ssh/config
        echo "  SSH config linked. Edit ~/.ssh/config to add your keys."
    fi
fi

# Starship prompt
echo ""
read -p "🚀 Install Starship prompt? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Add starship to Brewfile and install
    if ! grep -q "starship" "$DOTFILES/Brewfile"; then
        echo 'brew "starship"' >> "$DOTFILES/Brewfile"
    fi
    brew install starship

    # Enable starship in zshrc
    if grep -q "^# eval \"\$(starship init zsh)\"" "$DOTFILES/shell/zshrc"; then
        sed -i '' 's/^# eval "$(starship init zsh)"/eval "$(starship init zsh)"/' "$DOTFILES/shell/zshrc"
    fi

    # Link starship config
    mkdir -p ~/.config
    ln -sf "$DOTFILES/tools/starship.toml" ~/.config/starship.toml
fi

# Tmux
echo ""
read -p "🖥️  Set up tmux config? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Link tmux config
    ln -sf "$DOTFILES/tools/tmux.conf" ~/.tmux.conf

    # Install TPM (plugin manager) if not present
    if [ ! -d ~/.tmux/plugins/tpm ]; then
        echo "  Installing TPM (tmux plugin manager)..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

    echo "  tmux config linked. Press prefix+I (Ctrl-a then Shift+i) to install plugins."
fi

echo ""
echo "🍺 Installing Homebrew packages..."
brew bundle --file="$DOTFILES/Brewfile"

echo ""
echo "✅ Done. Restart terminal."
echo ""
echo "💡 Optional:"
echo "   - Run: $DOTFILES/macos/defaults.sh  (macOS tweaks)"

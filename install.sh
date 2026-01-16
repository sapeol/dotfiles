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
    if ! grep -q "starship init zsh" "$DOTFILES/shell/zshrc" | grep -v "^#"; then
        sed -i '' 's/^# eval "$(starship init zsh)"/eval "$(starship init zsh)"/' "$DOTFILES/shell/zshrc"
    fi
fi

echo ""
echo "🍺 Installing Homebrew packages..."
brew bundle --file="$DOTFILES/Brewfile"

echo ""
echo "✅ Done. Restart terminal."
echo ""
echo "💡 Optional:"
echo "   - Run: $DOTFILES/macos/defaults.sh  (macOS tweaks)"

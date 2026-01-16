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

echo ""
echo "🍺 Installing Homebrew packages..."
brew bundle --file="$DOTFILES/Brewfile"

echo ""
echo "✅ Done. Restart terminal."
echo ""
echo "💡 Optional:"
echo "   - Run: ~/dotfiles/macos/defaults.sh  (macOS tweaks)"
echo "   - Uncomment: eval \"\$(starship init zsh)\" in ~/.zshrc if using starship"

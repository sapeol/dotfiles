#!/usr/bin/env bash
# macOS defaults - run with caution!
# Backup your settings first: defaults read > ~/defaults-backup.txt

set -e

echo "🍎 Applying macOS defaults..."

# Trackpad: enable tap to click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Keyboard: faster key repeat
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: default to list view
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Finder: keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# No .DS_Store on network or USB drives
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Screenshots: save to Downloads instead of Desktop
defaults write com.apple.screencapture location -string "$HOME/Downloads"

# Dock: auto-hide
defaults write com.apple.dock autohide -bool true

# Dock: remove delay
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0

# Restart affected apps
echo "🔄 Restarting Finder and Dock..."
killall Finder 2>/dev/null || true
killall Dock 2>/dev/null || true

echo "✅ Done. Some changes require restart."

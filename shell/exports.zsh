# PATH
# Note: Assumes dotfiles are symlinked at ~/dotfiles or adjust path below
export PATH="$HOME/.local/bin:$PATH"

# History
export HISTSIZE=10000
export HISTFILE="$HOME/.zsh_history"
setopt SHARE_HISTORY  # Share history between terminals
setopt HIST_IGNORE_DUPS  # Don't record dupes
setopt HIST_IGNORE_SPACE  # Don't record commands starting with space

# Homebrew
export HOMEBREW_NO_AUTO_UPDATE=1  # Faster brew commands
export HOMEBREW_PREFIX="$(brew --prefix)"

# Editor
export EDITOR=vim
export VISUAL=vim

# Pager
export PAGER="less -R"
export LESS="-R --quit-if-one-screen"

# Node.js (npm global packages)
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"

# FZF (fuzzy finder)
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --color=dark'

# Bat (better cat)
export BAT_THEME="TwoDark"


# Android SDK (ADB)
export ANDROID_SDK_ROOT="/opt/homebrew/share/android-commandlinetools"
export PATH="$ANDROID_SDK_ROOT/platform-tools:$PATH"

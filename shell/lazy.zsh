# Lazy load heavy tools (only load when first used)

# NVM / Node version manager
nvm() {
  unset -f nvm
  export NVM_DIR="$HOME/.nvm"
  [ -s "$(brew --prefix nvm)/nvm.sh" ] && source "$(brew --prefix nvm)/nvm.sh"
  nvm "$@"
}

# Pyenv (Python version manager)
pyenv() {
  unset -f pyenv
  eval "$(pyenv init -)"
  pyenv "$@"
}

# Jenv (Java version manager)
jenv() {
  unset -f jenv
  export JENV_ROOT="$HOME/.jenv"
  eval "$(jenv init -)"
  jenv "$@"
}

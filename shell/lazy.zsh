# Lazy load heavy tools (only load when first used)

# fnm (Fast Node Manager)
fnm() {
  unset -f fnm
  eval "$(fnm env --use-on-cd)"
  fnm "$@"
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

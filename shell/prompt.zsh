# Minimal git-aware prompt (only used if starship is not active)
autoload -Uz vcs_info
precmd() { vcs_info }
setopt prompt_subst

zstyle ':vcs_info:git:*' formats ' [%F{green}%b%f]'
zstyle ':vcs_info:git:*' actionformats ' [%F{red}%b|%a%f]'

# Prompt: ~/dotfiles [main]$
PROMPT='%~${vcs_info_msg_0_}$ '

# Only set RPROMPT if starship is not active
if [[ -z "$STARSHIP_SHELL" ]]; then
  RPROMPT='%*'
fi

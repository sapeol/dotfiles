# FZF - Fuzzy finder integration

# Use fd if available for faster file search
if command -v fd &>/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi

# Better colors
export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --border
  --color=dark
  --color=fg:-1,fg+:#ffffff,bg:-1,bg+:#3e4452
  --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#87ff00
  --color=prompt:#d7005f,spinner:#af5fff,pointer:#af5fff,header:#87afaf
'

# Key bindings (Ctrl+R: history, Ctrl+T: files, Alt+C: dirs)
if command -v fzf &>/dev/null; then
  source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh" 2>/dev/null || true
  source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2>/dev/null || true
fi

# FZF functions
# Ctrl-G - Fuzzy git branch checkout
_fzf_git_branch() {
  local branches branch
  branches=$(git branch --all) &&
    branch=$(echo "$branches" | fzf +s +m -e) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}
zle -N _fzf_git_branch
bindkey '^G' _fzf_git_branch

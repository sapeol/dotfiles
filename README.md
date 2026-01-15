# Dotfiles

Minimal, suckless-inspired dotfiles for macOS.

## Structure

```
dotfiles/
├── README.md
├── install.sh
├── Brewfile
├── git/
│   ├── gitconfig
│   ├── gitignore_global
│   ├── tigrc
│   └── commit-template.txt
├── shell/
│   ├── zshrc
│   ├── aliases.zsh
│   ├── exports.zsh
│   ├── prompt.zsh
│   ├── fzf.zsh
│   ├── node.zsh
│   └── lazy.zsh
├── tools/
│   ├── lazygit.yml
│   ├── tmux.conf
│   ├── bat.conf
│   ├── ripgrep.conf
│   └── starship.toml
├── vim/
│   └── .vimrc
├── ssh/
│   └── config
├── macos/
│   └── defaults.sh
└── bin/
    ├── git-clean-merged
    ├── git-cleanup
    ├── git-root
    ├── git-fzf-branch
    ├── git-new-branch
    └── git-undo
```

## Bootstrap

```bash
git clone https://github.com/sapeol/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Features

### Git

| Command | Tool |
|---------|------|
| `git st` | Status (compact) |
| `git lg` | Log graph |
| `git br` | Branches with tracking |
| `git amend` | Amend last commit |
| `lg` | lazygit (TUI) |
| `tg` | tig (history browser) |

### Bin Scripts

| Script | Purpose |
|--------|---------|
| `git-root` | Jump to repo root |
| `git-cleanup` | Delete merged branches |
| `git-fzf-branch` | Fuzzy branch switcher |
| `git-new-branch <name>` | Create branch from main |
| `git-undo` | Undo last commit (keep changes) |

### Shell Aliases

```bash
gs    # git status
gl    # git log graph
gb    # git branches
lg    # lazygit
tg    # tig
```

### Node.js

```bash
nr    # npm run
ni    # npm install
ns    # npm start
nt    # npm test
```

### Better Defaults

| Tool | Replaces | Why |
|------|----------|-----|
| `bat` | `cat` | Syntax highlighting |
| `fd` | `find` | Faster, simpler |
| `rg` | `grep` | 10-100x faster |
| `exa` | `ls` | Colors, git status |
| `delta` | git diff | Side-by-side, highlighting |
| `fzf` | Ctrl+R | Fuzzy search everything |
| `zoxide` | `cd` | Smart directory jumping |

## Philosophy

- Simple over feature-rich
- CLI over GUI
- Edit config, don't hide it
- Additive minimalism: only what you use daily

## Optional

- Run `~/dotfiles/macos/defaults.sh` for macOS tweaks
- Uncomment `eval "$(starship init zsh)"` in `~/.zshrc` for starship prompt

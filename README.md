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
| `eza` | `ls` | Colors, git status |
| `delta` | git diff | Side-by-side, highlighting |
| `fzf` | Ctrl+R | Fuzzy search everything |
| `zoxide` | `z` command | Smart directory jumping |

**Note:** `cat`, `ls`, and `grep` are aliased to use the better tools. Use `\cat`, `\ls`, or `\grep` to bypass.

## Tool Deep Dive

### `bat` → better `cat`

```bash
bat file.js          # Syntax highlighted, line numbers
bat -p file.js       # Plain mode (no line numbers)
bat --diff file.js   # Show git changes inline
```

**Why:** Shows code with syntax highlighting, line numbers, and git diff indicators. Auto-paging for large files.

---

### `fd` → better `find`

```bash
fd "\.js$"           # Find all JS files (regex)
fd cli src/          # Find "cli" inside src/
fd -t d              # Find directories only
fd -H                # Include hidden files
fd -e rs             # Find by extension
```

**Why:** 10-100x faster than find, simpler syntax, respects `.gitignore`, built-in regex.

---

### `rg` (ripgrep) → better `grep`

```bash
rg "function"        # Search recursively (fast!)
rg -i "error"        # Case insensitive
rg -t py "import"    # Only Python files
rg --files-only      # Just filenames, no content
rg -v "test"         # Invert match (exclude)
```

**Why:** Written in Rust, parallelizes across CPU cores. Auto-skips `node_modules/`, `.git/`, respects `.gitignore`. Most teams switch codebase search from grep to rg instantly.

---

### `eza` → better `ls`

```bash
eza -la              # Long view, all files
eza --tree           # Directory tree
eza --tree -L 2      # Tree, 2 levels deep
eza -lg              # Long view with git status
eza -s extension     # Sort by extension
```

**Why:** Smart colors by file type, shows git status (modified/staged), proper symlink targets, tree view built-in.

---

### `zoxide` → smarter `cd`

```bash
z dotfiles           # Jump to dotfiles (remembers location)
z work               # Jump to work project
z ..                 # Go up (like cd ..)
zi                   # Interactive selection
```

**Why:** Learns which directories you use most. Fuzzy matching means you don't need full paths. Type `z doc` → jumps to your most-used "doc" directory anywhere on your system.

---

### `gh` → GitHub CLI

```bash
gh pr list           # List pull requests
gh pr view 123       # View PR details
gh pr checkout 123   # Checkout PR branch locally
gh issue create      # Create issue from terminal
gh repo view         # View repo info
gh release create    # Create release
```

**Why:** Stay in terminal for GitHub tasks. No browser needed for PRs, issues, releases.

---

### `fnm` → Fast Node Manager

```bash
fnm install 20       # Install Node 20
fnm use 20           # Use Node 20 in current shell
fnm default 20       # Set Node 20 as default
fnm list             # List installed versions
fnm ls-remote        # List available versions
```

**Why:** Faster than nvm because it's written in Rust and doesn't hook into every shell startup. Works with `.nvmrc` files.

---

## Philosophy

- Simple over feature-rich
- CLI over GUI
- Edit config, don't hide it
- Additive minimalism: only what you use daily

## Optional

- Run `~/dotfiles/macos/defaults.sh` for macOS tweaks
- Uncomment `eval "$(starship init zsh)"` in `~/.zshrc` for starship prompt

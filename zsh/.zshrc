# ============================================================
#  .zshrc — Lakshin's Personal Zsh Config
#  Requires: Oh My Zsh + Powerlevel10k + zsh plugins
#  Install guide at the bottom of this file
# ============================================================

# ── Powerlevel10k instant prompt (must be near top) ─────────
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── Oh My Zsh Setup ─────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# ── Plugins ──────────────────────────────────────────────────
# zsh-autosuggestions: ghost-text suggestions as you type
# zsh-syntax-highlighting: colors commands green/red before you hit Enter
# z: jump to frecent directories (e.g. `z projects`)
# git: aliases like gst, gco, gp, gl
# fzf: fuzzy finder for history (Ctrl+R) and files (Ctrl+T)
plugins=(
  git
  z
  fzf
  docker
  sudo           # press ESC twice to prepend sudo to last command
  colored-man-pages
  command-not-found
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# ── Powerlevel10k Config ─────────────────────────────────────
# Run `p10k configure` anytime to re-run the wizard
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ── Environment ──────────────────────────────────────────────
export EDITOR="code"          # change to nvim/vim if you prefer
export LANG="en_US.UTF-8"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"  # pretty man pages (needs bat)

# ── History ──────────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS        # don't save duplicate commands
setopt HIST_IGNORE_SPACE       # commands starting with space won't be saved
setopt SHARE_HISTORY           # share history across terminals

# ── Navigation ───────────────────────────────────────────────
setopt AUTO_CD                 # type a dir name to cd into it
setopt AUTO_PUSHD              # cd pushes to dir stack automatically
setopt PUSHD_IGNORE_DUPS

# ── Completion ───────────────────────────────────────────────
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'   # case-insensitive tab complete

# ── Key Bindings ─────────────────────────────────────────────
bindkey '^[[A' history-search-backward   # Up arrow: search history
bindkey '^[[B' history-search-forward    # Down arrow
bindkey '^H' backward-kill-word          # Ctrl+Backspace: delete word

# ── Aliases: Navigation ──────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'            # cd to previous dir

# ── Aliases: Listing ─────────────────────────────────────────
# Requires: eza (modern ls replacement) → `sudo dnf install eza`
if command -v eza &>/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -lah --icons --group-directories-first --git'
  alias lt='eza --tree --icons --level=2'
  alias l='eza -1 --icons'
else
  alias ls='ls --color=auto'
  alias ll='ls -lah --color=auto'
fi

# ── Aliases: Files ───────────────────────────────────────────
# Requires: bat (pretty cat) → `sudo dnf install bat`
if command -v bat &>/dev/null; then
  alias cat='bat --paging=never'
  alias less='bat'
fi

# ── Aliases: Git ─────────────────────────────────────────────
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias glog='git log --oneline --graph --decorate --all'
alias gdiff='git diff --stat'

# ── Aliases: System ──────────────────────────────────────────
alias dnfi='sudo dnf install'
alias dnfs='dnf search'
alias dnfu='sudo dnf upgrade'
alias reload='source ~/.zshrc && echo "✓ zshrc reloaded"'
alias zshrc='$EDITOR ~/.zshrc'
alias hosts='sudo $EDITOR /etc/hosts'
alias ip='curl -s https://ipinfo.io/ip && echo'
alias ports='ss -tulanp'
alias df='df -hT'
alias du='du -sh * | sort -h'
alias free='free -h'
alias psg='ps aux | grep -i'

# ── Aliases: Dev ─────────────────────────────────────────────
alias py='python3'
alias pip='pip3'
alias serve='python3 -m http.server 8080'
alias dk='docker'
alias dkc='docker compose'
alias mvnq='mvn quarkus:dev'
alias mvni='mvn clean install -DskipTests'

# ── Functions ────────────────────────────────────────────────

# mkcd: mkdir + cd in one
mkcd() { mkdir -p "$1" && cd "$1" }

# extract: smart extraction for any archive type
extract() {
  case "$1" in
    *.tar.gz|*.tgz)  tar xzf "$1"   ;;
    *.tar.bz2)       tar xjf "$1"   ;;
    *.tar.xz)        tar xJf "$1"   ;;
    *.zip)           unzip "$1"     ;;
    *.7z)            7z x "$1"      ;;
    *.gz)            gunzip "$1"    ;;
    *.rar)           unrar x "$1"   ;;
    *)               echo "Don't know how to extract '$1'" ;;
  esac
}

# fcd: fuzzy cd using fzf
fcd() {
  local dir
  dir=$(find ${1:-.} -type d 2>/dev/null | fzf +m) && cd "$dir"
}

# fh: fuzzy search shell history and execute
fh() {
  eval $(fc -l 1 | fzf --tac | sed 's/ *[0-9]* *//')
}

# portused: check what's using a port
portused() { sudo lsof -i :"$1" }

# gitnew: create and push a new branch
gitnew() { git checkout -b "$1" && git push -u origin "$1" }

# ── FZF config ───────────────────────────────────────────────
export FZF_DEFAULT_OPTS='
  --height 40%
  --layout=reverse
  --border rounded
  --color=bg+:#1e1e2e,bg:#181825,spinner:#f5c2e7,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5c2e7
  --color=marker:#f5c2e7,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
'
# Use fd for fzf file search if available
if command -v fd &>/dev/null; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# ── zsh-autosuggestions config ───────────────────────────────
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#6c7086'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
bindkey '^ ' autosuggest-accept   # Ctrl+Space to accept suggestion

# ── Syntax highlighting config ───────────────────────────────
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

# ── Welcome message ──────────────────────────────────────────
echo "  $(date '+%A, %d %B %Y — %H:%M')  |  $(uname -n)"

# ============================================================
#  INSTALLATION GUIDE
# ============================================================
#
#  1. Install Oh My Zsh:
#     sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#
#  2. Install Powerlevel10k:
#     git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
#       ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
#
#  3. Install plugins:
#     git clone https://github.com/zsh-users/zsh-autosuggestions \
#       ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
#
#     git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
#       ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
#
#  4. Install CLI tools (optional but recommended):
#     sudo dnf install eza bat fzf fd-find
#
#  5. Install a Nerd Font (required for icons in p10k):
#     Download from https://www.nerdfonts.com → set in your terminal settings
#     Recommended: "JetBrainsMono Nerd Font" or "MesloLGS NF"
#
#  6. Copy this file to ~/.zshrc, then run:
#     source ~/.zshrc
#     p10k configure   ← interactive prompt theme wizard
#
# ============================================================

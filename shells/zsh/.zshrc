# =========
# = Paths =
# =========

export XDG_CONFIG_DIR="/etc/xdg"
export USER_TOOLS_DIR="$HOME/.tools"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIR="/usr/local/share/:/usr/share/"

# Zinit
export ZINIT_HOME="$USER_TOOLS_DIR/.Zinit"

# Starship
export STARSHIP_CONFIG="$XDG_CONFIG_HOME/starship.toml"

# Homebrew
export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"

# MacOS
export HOMEBREW_PATH="/opt/homebrew"

# Linux
export PATH=$HOMEBREW_PATH/bin:$PATH
export HOMEBREW_PATH="/home/linuxbrew/.linuxbrew"

# Rust
export PATH="$CARGO_HOME/bin:$PATH"
export CARGO_HOME="$USER_TOOLS_DIR/.Rust/.cargo"
export RUSTUP_HOME="$USER_TOOLS_DIR/.Rust/.rustup"


# =========
# = Tools =
# =========

alias l='ls --color'
alias ls='ls --color'
alias la='ls -a --color'
alias ll='ls -a -l --color'

# fd -- A modern replacement for find
if [ "$(command -v fd)" ]; then
    unalias -m 'find'
    alias find='fd'
fi

# ripgrep -- A modern replacement for grep
if [ "$(command -v rg)" ]; then
    unalias -m 'grep'
    alias grep='rg -S'
    alias rg='rg -S'
fi

# exa  -- A modern replacement for ls.
if [ "$(command -v exa)" ]; then
    unalias -m 'l'
    unalias -m 'll'
    unalias -m 'la'
    unalias -m 'ls'
    alias l='exa -G  --color auto --icons -s type'
    alias ls='exa -G  --color auto --icons -s type'
    alias la='exa -G --color always --icons -a -s type'
    alias ll='exa -l --color always --icons -a -s type'
fi

# bat -- A cat clone with syntax highlighting and Git integration.
if [ "$(command -v bat)" ]; then
    unalias -m 'cat'
    # alias cat='bat -pp --theme="Nord"'
    alias cat='bat --theme="Nord"'
fi


# =========
# = Zinit =
# =========

# Installer
if [[ ! -f $ZINIT_HOME/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$ZINIT_HOME" && command chmod g-rwX "$ZINIT_HOME"
    command git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
source "$ZINIT_HOME/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Plugins
if [ "$(command -v zinit)" ]; then
    zinit light zsh-users/zsh-completions
    zinit light zsh-users/zsh-autosuggestions
    zinit light zsh-users/zsh-syntax-highlighting
fi


# ============
# = StarShip =
# ============

if [ "$(command -v starship)" ]; then
    eval "$(starship init zsh)"
fi

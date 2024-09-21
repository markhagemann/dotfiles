if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light-mode for zdharma-continuum/zinit-annex-bin-gem-node
zinit light laggardkernel/zsh-tmux
zinit ice atinit"
        ZSH_TMUX_FIXTERM=true;
        ZSH_TMUX_AUTOSTART=false;
        ZSH_TMUX_AUTOCONNECT=true;"
zinit pack for fzf
zinit pack for pyenv
zinit light Aloxaf/fzf-tab
zinit light jeffreytse/zsh-vi-mode

zinit wait lucid light-mode for lukechilds/zsh-nvm
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions
# ogham/exa, replacement for ls
zinit ice wait"2" lucid from"gh-r" as"program" mv"exa* -> exa"
zinit light ogham/exa
# sharkdp/bat
zinit ice as"command" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat
# All of the above using the for-syntax and also z-a-bin-gem-node annex
zinit wait"1" lucid from"gh-r" as"null" for \
     sbin"**/bat"       @sharkdp/bat \
     sbin"exa* -> exa"  ogham/exa
zinit ice pick'init.zsh'
zi for \
    from'gh-r' \
    sbin'**/rg -> rg' \
  BurntSushi/ripgrep

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found
zinit snippet OMZ::plugins/tmux/tmux.plugin.zsh

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Keybindings
zinit ice depth=1
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

export XDG_CONFIG_HOME="$HOME/.config"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export NVM_COMPLETION=true
export NVM_SYMLINK_CURRENT="true"

TMUX_DIR="~/.config/tmux"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Import private exports that shouldn't be committed
PRIVEXPORTFILE=~/.zshrcpriv
source $PRIVEXPORTFILE

function zshalias()
{
  grep "^alias" ~/.zshrc > ~/.zshenv
}

# Add path
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/neovim/bin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
export PATH=$PATH:$HOME/bin
export PATH=~/.local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH="$PATH:$HOME/.cargo/bin"
export HOMEGOPATH=$HOME/go
export PATH="$PATH:$HOMEGOPATH/bin"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# Shell integrations
eval "$(zoxide init zsh)"
# Use oh-my-posh
eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/negligible-custom.omp.toml)"

# Better ls
alias ls="eza --icons=always"

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

if [ "$(uname)" = "Darwin" ];
then
  eval "$(gdircolors ~/.dir_colors)"
  COPY_COMMAND="pbcopy"
else
  eval "$(dircolors ~/.dir_colors)"
  COPY_COMMAND="wl-copy -n"
fi

# zsh-vi-mode settings
my_zvm_vi_yank() {
    zvm_vi_yank
    echo -en "${CUTBUFFER}" $COPY_COMMAND
}

my_zvm_vi_delete() {
    zvm_vi_delete
    echo -en "${CUTBUFFER}" $COPY_COMMAND
}

my_zvm_vi_change() {
    zvm_vi_change
    echo -en "${CUTBUFFER}" $COPY_COMMAND
}

my_zvm_vi_change_eol() {
    zvm_vi_change_eol
    echo -en "${CUTBUFFER}" $COPY_COMMAND
}

my_zvm_vi_substitute() {
    zvm_vi_substitute
    echo -en "${CUTBUFFER}" $COPY_COMMAND
}

my_zvm_vi_substitute_whole_line() {
    zvm_vi_substitute_whole_line
    echo -en "${CUTBUFFER}" $COPY_COMMAND
}

my_zvm_vi_put_after() {
    CUTBUFFER=$(pbpaste)
    zvm_vi_put_after
    zvm_highlight clear # zvm_vi_put_after introduces weird highlighting
}

my_zvm_vi_put_before() {
    CUTBUFFER=$(pbpaste)
    zvm_vi_put_before
    zvm_highlight clear # zvm_vi_put_before introduces weird highlighting
}

my_zvm_vi_replace_selection() {
    CUTBUFFER=$(pbpaste)
    zvm_vi_replace_selection
    echo -en "${CUTBUFFER}" $COPY_COMMAND
}

zvm_after_lazy_keybindings() {
    zvm_define_widget my_zvm_vi_yank
    zvm_define_widget my_zvm_vi_delete
    zvm_define_widget my_zvm_vi_change
    zvm_define_widget my_zvm_vi_change_eol
    zvm_define_widget my_zvm_vi_put_after
    zvm_define_widget my_zvm_vi_put_before
    zvm_define_widget my_zvm_vi_substitute
    zvm_define_widget my_zvm_vi_substitute_whole_line
    zvm_define_widget my_zvm_vi_replace_selection

    zvm_bindkey vicmd 'C' my_zvm_vi_change_eol
    zvm_bindkey vicmd 'P' my_zvm_vi_put_before
    zvm_bindkey vicmd 'S' my_zvm_vi_substitute_whole_line
    zvm_bindkey vicmd 'p' my_zvm_vi_put_after

    zvm_bindkey visual 'p' my_zvm_vi_replace_selection
    zvm_bindkey visual 'c' my_zvm_vi_change
    zvm_bindkey visual 'd' my_zvm_vi_delete
    zvm_bindkey visual 's' my_zvm_vi_substitute
    zvm_bindkey visual 'x' my_zvm_vi_delete
    zvm_bindkey visual 'y' my_zvm_vi_yank
}

# mac specific settings.
if [ "$(uname)" = "Darwin" ]; then
  export PATH="/opt/homebrew/opt/awscli@1/bin:$PATH"

  # 15 is lowest setting on UI
  # 8 was too fast causing duplicate keystrokes
  # 10 i think this causes issues in bash cli when editing commands, not sure
  defaults write -g InitialKeyRepeat -int 12

  # 2 is lowest setting on UI
  defaults write -g KeyRepeat -int 2

  # allow holding key instead of mac default holding key to choose alternate key
  defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
fi

# WSL 2 specific settings.
if grep -q "microsoft" /proc/version &>/dev/null; then

  case "$(uname -s)" in

    Linux)

    # Used for linux when `host.docker.internal` doesn't work in docker-compose
    export DOCKER_GATEWAY_HOST=$(hostname -i |awk '{print $1}')
    ;;

  esac

  # Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
  export IP=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}')
  # export DISPLAY=$IP:0.0
  export ADDITIONAL_DOCKER_PARAMS="--env WAYLAND_DISPLAY --env XDG_RUNTIME_DIR --env PULSE_SERVER -v /tmp/.X11-unix:/tmp/.X11-unix -v /mnt/wslg:/mnt/wslg"
  export LIBGL_ALWAYS_INDIRECT=0
  export MESA_D3D12_DEFAULT_ADAPTER_NAME="NVIDIA"

  # Automatically start dbus - https://nickymeuleman.netlify.app/blog/gui-on-wsl2-cypress
  # sudo /etc/init.d/dbus start &> /dev/null

  # https://dev.to/bowmanjd/install-docker-on-windows-wsl-without-docker-desktop-34m9
  DOCKER_DISTRO=$(. ~/os-details; echo "$DISTRIBUTION_NAME")
  DOCKER_DIR=/mnt/wsl/shared-docker
  DOCKER_SOCK="$DOCKER_DIR/docker.sock"
  export DOCKER_HOST="unix://$DOCKER_SOCK"
  if [ ! -S "$DOCKER_SOCK" ]; then
      mkdir -pm o=,ug=rwx "$DOCKER_DIR"
      chgrp docker "$DOCKER_DIR"
      /mnt/c/Windows/System32/wsl.exe -d $DOCKER_DISTRO sh -c "nohup sudo -b dockerd < /dev/null > $DOCKER_DIR/dockerd.log 2>&1"
  fi

fi

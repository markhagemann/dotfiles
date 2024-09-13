export XDG_CONFIG_HOME="$HOME/.config"

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

export GDK_SCALE=0.5
export GDK_DPI_SCALE=1.25

# Import private exports that shouldn't be committed
PRIVEXPORTFILE=~/.zshrcpriv
source $PRIVEXPORTFILE

# Fix to ignore warning about 'Insecure completion-dependent directories detected'
ZSH_DISABLE_COMPFIX=true

# If you come from bash you might have to change your $PATH.
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/neovim/bin:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
export PATH=$PATH:$HOME/bin
export PATH=~/.local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export HOMEGOPATH=$HOME/go
export PATH="$PATH:$HOMEGOPATH/bin"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
  eval "$(pyenv init -)"
fi

# Path to oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# TMUX
# Automatically start tmux
ZSH_TMUX_AUTOSTART=true
TMUX_DIR="~/.config/tmux"

# Automatically connect to a previous session if it exists
ZSH_TMUX_AUTOCONNECT=true

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# zstyle :omz:plugins:ssh-agent agent-forwarding on
plugins=(git node tmux z pyenv zsh-nvm zsh-autosuggestions fast-syntax-highlighting zsh-vi-mode)

## Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes
source ~/.oh-my-zsh/custom/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

function zshalias()
{
  grep "^alias" ~/.zshrc > ~/.zshenv
}

# Setting rg as the default source for fzf
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'

  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    -m --height 50% --border
  '

  # Apply the command to CTRL-T as well
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

## FZF FUNCTIONS ##

# Set FZF for z jump around
unalias z 2> /dev/null
z() {
    [ $# -gt 0 ] && _z "$*" && return
    cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

# fo [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fo() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-nvim} "${files[@]}"
}

# fh [FUZZY PATTERN] - Search in command history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# fbr [FUZZY PATTERN] - Checkout specified branch
# Include remote branches, sorted by most recent commit and limited to 30
fgb() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# tm [SESSION_NAME | FUZZY PATTERN] - create new tmux session, or switch to existing one.
# Running `tm` will let you fuzzy-find a session mame
# Passing an argument to `ftm` will switch to that session if it exists or create it otherwise
ftm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

# tm [SESSION_NAME | FUZZY PATTERN] - delete tmux session
# Running `tm` will let you fuzzy-find a session mame to delete
# Passing an argument to `ftm` will delete that session if it exists
ftmk() {
  if [ $1 ]; then
    tmux kill-session -t "$1"; return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux kill-session -t "$session" || echo "No session found to delete."
}

# fuzzy grep via rg and open in vim with line number
fgr() {
  local file
  local line

  read -r file line <<<"$(rg --no-heading --line-number $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
     vim $file +$line
  fi
}

source $ZSH/oh-my-zsh.sh

setopt CSH_NULL_GLOB
unsetopt correct_all
# Spell checks
setopt correct
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color? [Yes, No, Abort, Edit] "

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

_fix_cursor() {
   echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor)

# Remove duplicates in path
PATH=$(printf %s "$PATH" \
     | awk -vRS=: -vORS= '!a[$0]++ {if (NR>1) printf(":"); printf("%s", $0) }' )

eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/the-unnamed-custom.omp.json)"

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

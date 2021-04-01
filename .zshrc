# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

# eval "$(gdircolors ~/.dir_colors)" || "$(dircolors ~/.dir_colors)"
eval "$(dircolors ~/.dir_colors)" || "$(gdircolors ~/.dir_colors)"

# Import private exports that shouldn't be committed
PRIVEXPORTFILE=~/.zshrcpriv
source $PRIVEXPORTFILE

# Fix to ignore warning about 'Insecure completion-dependent directories detected'
ZSH_DISABLE_COMPFIX=true

# If you come from bash you might have to change your $PATH.
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/neovim/bin:$PATH"
export PATH=$PATH:$HOME/bin
export PATH=~/.local/bin:$PATH
# export PATH="$PATH:/mnt/c/Apps/Development/Onivim2"
export PATH="$PATH:/mnt/c/Apps/Development/Microsoft VS Code"
export PYENV_ROOT="$HOME/.pyenv"
export GOPATH=$HOME/go
export PATH="$PATH:$GOPATH/bin"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Path to oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

case "$(uname -s)" in

  Linux)

  # Used for linux when `host.docker.internal` doesn't work in docker-compose
  export DOCKER_GATEWAY_HOST=$(hostname -I |awk '{print $1}')
  ;;

esac

# Name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# ZSH_THEME="spaceship"
ZSH_THEME="powerlevel10k/powerlevel10k"

# TMUX
# Automatically start tmux
ZSH_TMUX_AUTOSTART=false

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
plugins=(git node tmux z zsh-nvm zsh-autosuggestions zsh-syntax-highlighting)

# Aliases
alias code="code.exe"
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias df="dotfiles"
alias dfstatus="dotfiles status -uno"
alias docker-remove-dangling-images='docker rmi $(docker images -f "dangling=true" -q)'
alias docker-remove-stopped-containers='docker rm -v $(docker ps -a -q -f status=exited)'
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
# This is specific to WSL 2. If the WSL 2 VM goes rogue and decides not to free
# up memory, this command will free your memory after about 20-30 seconds.
#   Details: https://github.com/microsoft/WSL/issues/4166#issuecomment-628493643
alias drop_cache="sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""
alias lg="lazygit"
alias listlargesthomefiles="du -h /home/drache | sort -rh | head -5"
alias listlogfilesize="du -h /home/drache/.cache/nvim | sort -rh | head -5"
alias removenvimlog="rm /home/drache/.cache/nvim/log"
alias etmux="nvim ~/.tmux.conf"
alias evim="nvim ~/.config/nvim/init.lua"
alias ezsh="nvim ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
# alias oni="oni2.exe"
alias synctime="sudo hwclock -s"
alias vim="nvim"

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

  # This is for Nord theme
  # export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  #   -m --height 50% --border
  #   --color fg:#D8DEE9,bg:#2E3440,hl:#A3BE8C,fg+:#D8DEE9,bg+:#434C5E,hl+:#A3BE8C
  #   --color pointer:#BF616A,info:#4C566A,spinner:#4C566A,header:#4C566A,prompt:#81A1C1,marker:#EBCB8B
  # '
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

# Set Spaceship as prompt
# autoload -U promptinit; promptinit
# prompt spaceship
# SPACESHIP_TIME_SHOW=true
# SPACESHIP_TIME_COLOR=#00afff
# SPACESHIP_TIME_12HR=true
# SPACESHIP_DOCKER_SHOW=false
# SPACESHIP_BATTERY_SHOW=false
# SPACESHIP_PACKAGE_SHOW=false
# SPACESHIP_NODE_SHOW=false
# SPACESHIP_GIT_STATUS_STASHED=''
# SPACESHIP_GIT_BRANCH_COLOR=#8787ff
# SPACESHIP_DIR_COLOR=#00d7d7

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

_fix_cursor() {
   echo -ne '\e[5 q'
}

precmd_functions+=(_fix_cursor)

# YVM Stuff
export YVM_DIR=$HOME/.yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh
export PATH=~/.yarn/bin:$PATH

# WSL 2 specific settings.
if grep -q "microsoft" /proc/version &>/dev/null; then
  # Requires: https://sourceforge.net/projects/vcxsrv/ (or alternative)
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0

  # Automatically start dbus - https://nickymeuleman.netlify.app/blog/gui-on-wsl2-cypress
  sudo /etc/init.d/dbus start &> /dev/null
fi

export GDK_SCALE=0.5
export GDK_DPI_SCALE=1.25


[[ $TMUX = "" ]] && export TERM="xterm-256color"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export YVM_DIR=/home/drache/.yvm

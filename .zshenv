# Aliases
# alias cat=bat
alias cl='clear'
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias gdate="date"
alias delete-merged-local-branches='git checkout develop && git pull && git branch --merged | grep -Ev "(^\*|production|staging|edge|develop)" | xargs git branch -d'
# This is specific to WSL 2. If the WSL 2 VM goes rogue and decides not to free
# up memory, this command will free your memory after about 20-30 seconds.
#   Details: https://github.com/microsoft/WSL/issues/4166#issuecomment-628493643
alias drop_cache="sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""
alias etmux="nvim ~/.config/tmux/tmux.conf"
alias evim="cd ~/.config/nvim && nvim ~/.config/nvim/init.lua"
alias ezsh="nvim ~/.zshrc"
alias installpacker="git clone https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim"
alias kittyupdate='curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin'
alias la=tree
alias lzd="lazydocker"
alias lzg="lazygit"
alias listlargesthomefiles="du -h /home/drache | sort -rh | head -5"
alias listlogfilesize="du -h /home/drache/.cache/nvim | sort -rh | head -5"
alias ls='ls --color'
alias removenvimlog="rm /home/drache/.cache/nvim/log"
alias synctime="sudo hwclock -s"
alias vim="nvim"
# . "$HOME/.cargo/env"

# Git
alias dot="dotfiles"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
alias dst="dot status"
alias ddiff="dot diff"
alias dc="dot add -p"
alias dc="dot commit -m"
alias dca="dot commit -a -m"
alias dp="dot push origin HEAD"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gst="git status"
alias glog="git log --graph --topo-order --pretty='%w(100,0,6)%C(yellow)%h%C(bold)%C(black)%d %C(cyan)%ar %C(green)%an%n%C(bold)%C(white)%s %N' --abbrev-commit"
alias gdiff="git diff"
alias gco="git checkout"
alias gcf="git checkout -b"
alias gb='git branch'
alias gba='git branch -a'
alias gadd='git add'
alias ga='git add -p'

# Docker
alias dco="docker compose"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias dx="docker exec -it"
alias docker-remove-dangling-images='docker rmi $(docker images -f "dangling=true" -q)'
alias docker-remove-stopped-containers='docker rm -v $(docker ps -a -q -f status=exited)'
alias docker-stop-all-containers='docker stop $(docker ps -q)'

# Dirs
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# K8S
alias k="kubectl"
alias ka="kubectl apply -f"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kl="kubectl logs"
alias kgpo="kubectl get pod"
alias kgd="kubectl get deployments"
alias kx="kubectx"
alias kns="kubens"
alias kl="kubectl logs -f"
alias ke="kubectl exec -it"
alias kcns='kubectl config set-context --current --namespace'
alias podname=''

# Corepack aliases
alias yarn="corepack yarn"
alias yarnpkg="corepack yarnpkg"
alias pnpm="corepack pnpm"
alias pnpx="corepack pnpx"
alias npm="corepack npm"
alias npx="corepack npx"

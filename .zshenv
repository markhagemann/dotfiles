# Aliases
alias config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME"
alias gdate="date"
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
alias evim="cd ~/.config/nvim && nvim ~/.config/nvim/init.lua"
alias ezsh="nvim ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
# alias oni="oni2.exe"
alias synctime="sudo hwclock -s"
alias vim="nvim"

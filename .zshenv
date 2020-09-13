alias config='/usr/bin/git --git-dir=/home/drache/.cfg/ --work-tree=/home/drache'
alias docker-remove-dangling-images='docker rmi $(docker images -f "dangling=true" -q)'
alias docker-remove-stopped-containers='docker rm -v $(docker ps -a -q -f status=exited)'
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
alias drop_cache="sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""
alias envim="nvim ~/.config/nvim/init.vim"
alias etmux="nvim ~/.tmux.conf"
alias evim="nvim ~/.config/nvim/init.vim"
alias ezsh="nvim ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias synctime="sudo hwclock -s"
alias vim="nvim"

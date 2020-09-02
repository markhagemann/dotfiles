alias bat="batcat"
alias config='/usr/bin/git --git-dir=/home/drache/.cfg/ --work-tree=/home/drache'
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim="nvim"
alias docker-remove-dangling-images='docker rmi $(docker images -f "dangling=true" -q)'
alias docker-remove-stopped-containers='docker rm -v $(docker ps -a -q -f status=exited)'

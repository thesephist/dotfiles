# git aliases FTW
alias gls="/bin/ls -G"
alias ls="ls -haFG"
alias tmux="tmux -2"
alias g="git"
alias gs="git status"
alias ga="git add ."
alias gd="git diff"
alias gc="git commit -m"
alias gap="git add -p"
alias gac="git add -A; git commit -m"
alias gb="git branch"
alias gk="git checkout"
alias gl="git log --oneline"
alias ghr="git reset --hard HEAD"
alias gsh="git push"
alias gll="git pull"
alias vi="vim -u NONE"

# other rust/CLI aliases
alias cat="bat"
alias git="hub"
alias grep="grep --color"
alias less="less -R" # color
alias video-dl="youtube-dl -f 'mp4[height>=?720]'"
alias audio-dl="youtube-dl -x --prefer-ffmpeg --audio-format=mp3"

set -x fish_user_paths $HOME/go/bin $HOME/.cargo/bin $fish_user_paths
set -x GOPATH $HOME/go
set -x GOBIN $HOME/go/bin

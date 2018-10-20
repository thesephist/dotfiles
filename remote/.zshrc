setopt autocd
zstyle :compinstall filename '/home/thesephist/.zshrc'
autoload -Uz compinit
export PS1="
[%D|%*] %m%d%%
❯ "
compinit

alias ls="ls -haFG --color"
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
alias vi="vim -u NONE"


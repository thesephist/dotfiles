# If just typing in a dir, cd to it
setopt autocd

# My workstations are mostly Macs. If Linux/BSD, this line needs changed.
zstyle :compinstall filename '/home/l/li/linuslee/'

# git repo statusline
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
autoload -Uz compinit
export PS1="
[%D|%*] %m%d%%
❯ "
compinit
printf '=== SL/T ===\n'

# git aliases FTW
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
alias gll="git pull"
alias gsh="git push"
alias vi="vim -u NONE"

# lol
alias idk="printf \"¯\_(ツ)_/¯\" | pbcopy && echo \"¯\_(ツ)_/¯ copied to clipboard\""

# I can't type for shit
alias test="npm test"
alias tes="npm test"
alias est="npm test"
alias tst="npm test"

alias cat="bat"

# Yarn env vars
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# OCF lab workstations' desktoprc source .profile too early, so source it again
source ~/.profile


# If just typing in a dir, cd to it
setopt autocd

# My workstations are mostly Macs. If Linux/BSD, this line needs changed.
zstyle :compinstall filename '/home/thesephist/.zshrc'

# git repo statusline
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
PATH=$PATH:/Users/thesephist/bin
autoload -Uz compinit
export PS1="
[%D|%*] %m%d%%
❯ "
compinit
printf '=== SL/T ===\n'

# git aliases FTW
alias ls="ls -haFG --color" # NOTE: macOS's default ls doesn't take the --color flag
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

# lol
alias idk="printf \"¯\_(ツ)_/¯\" | pbcopy && echo \"¯\_(ツ)_/¯ copied to clipboard\""

# Trash function for the CLI shell, instead of rm
function trash () {
    mkdir -p ~/.trash/
    mv "$@" ~/.trash/
}


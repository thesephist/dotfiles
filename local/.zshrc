# If just typing in a dir, cd to it
setopt autocd

# My workstations are mostly Macs. If Linux/BSD, this line needs changed
# to be /home/thesephist/.zshrc instead.
zstyle :compinstall filename '/Users/thesephist/.zshrc'

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
alias gsh="git push"
alias gll="git pull"
alias vi="vim -u NONE"

# auxiliary aliases
alias less="less -R"
alias youtube-dl="youtube-dl -f 'mp4[height>=?720]'"
alias audio-dl="youtube-dl -x --prefer-ffmpeg --audio-format=mp3"
alias idk="printf \"¯\_(ツ)_/¯\" | pbcopy && echo \"¯\_(ツ)_/¯ copied to clipboard\""

export HISTSIZE=1000
# For some reason, Alacritty has trouble picking up the right PATHs
export PATH=$PATH:/Users/thesephist/.cargo/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:/Users/thesephist/bin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=$PATH:$HOME/go/bin
export GOPATH=$HOME/go
export GOBIN=$HOME/go/bin

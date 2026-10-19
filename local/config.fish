alias gls="/bin/ls -G"
alias ls="ls -haFG"
alias tmux="tmux -2"
alias g="git"
alias gs="git status"
alias ga="git add"
alias gaa="git add ."
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
alias glll="klisp $HOME/pull-all.klisp"

# other rust/CLI aliases
alias cat="bat"
alias grep="grep --color"
alias less="less -R" # color
alias video-dl="yt-dlp -f 'mp4[height>=?720]'"
alias audio-dl="yt-dlp -x --audio-format=mp3"

fish_add_path $HOME/.local/bin $HOME/go/bin $HOME/.cargo/bin
set -x GOPATH $HOME/go
set -x GOBIN $HOME/go/bin
set -x SUPERSTAT_ROOT $HOME/src
set -x DISABLE_AUTO_HOBGOBLIN_INFRA_UP "1"

# Apple Silicon Homebrew, including keg-only Node.
fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /opt/homebrew/opt/node@24/bin
fish_add_path $BUN_INSTALL/bin

fish_vi_key_bindings

if test -f $__fish_config_dir/config.local.fish
    source $__fish_config_dir/config.local.fish
end

if test -f .env.fish
    source .env.fish
end
if test -f venv/bin/activate.fish
    source venv/bin/activate.fish
end

function git-delete-other-branches
    set current (git branch --show-current 2>/dev/null)

    if test "$current" != main
        echo "Aborting: current branch is '"(string join "" -- $current)"', not 'main'." >&2
        return 1
    end

    for branch in (git for-each-ref --format='%(refname:short)' refs/heads/)
        if test "$branch" != main
            git branch -D -- "$branch"
        end
    end
end

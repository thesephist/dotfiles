setopt autocd
zstyle :compinstall filename '/home/thesephist/.zshrc'
autoload -Uz compinit
export PS1="
[%D|%*] %m%d%%
❯ "
compinit


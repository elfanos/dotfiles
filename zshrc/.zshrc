export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export PGHOST="/var/run/postgresql"
export PATH="$HOME/.tmuxifier/bin:$PATH"

HISTFILE=~/.history
HISTSIZE=10000
SAVEHIST=50000

setopt inc_append_history


# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile 
HISTSIZE=100 
SAVEHIST=1000 
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/ralle/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
eval "$(tmuxifier init -)"
eval "$(starship init zsh)"

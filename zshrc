export ZSH="/Users/b.thng/.oh-my-zsh"
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'

plugins=(git)

# Load the shell dotfiles, and then some:
for file in ~/.{aliases,}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

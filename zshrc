export ZSH="/Users/bthng/.oh-my-zsh"
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
export AIRFLOW_BUSINESS_UNIT="pandata"
export PATH="/usr/local/opt/libpq/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

plugins=(
  git
  zsh-autosuggestions
  asdf
)

# Load the shell dotfiles, and then some:
for file in ~/.{aliases,ignores/exports}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/usr/local/opt/python@3.7/bin:$PATH"
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/bthng/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/bthng/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/bthng/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/bthng/google-cloud-sdk/completion.zsh.inc'; fi

export ZSH="/Users/b.thng/.oh-my-zsh"
ZSH_THEME="robbyrussell"

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
export AIRFLOW_BUSINESS_UNIT="pandata"
export PATH="/usr/local/opt/libpq/bin:$PATH"

plugins=(git)

# Load the shell dotfiles, and then some:
for file in ~/.{aliases,ignores/exports}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/b.thng/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/b.thng/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/b.thng/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/b.thng/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="$HOME/.poetry/bin:$PATH"

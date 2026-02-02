export ZSH="/Users/bthng/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  asdf
  direnv
  git
  virtualenv
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
export AIRFLOW_BUSINESS_UNIT="pandata"
export JAVA_HOME=/opt/homebrew/Cellar/openjdk@17/17.0.10/libexec/openjdk.jdk/Contents/Home

autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# Load the shell dotfiles, and then some:
for file in ~/.{aliases,ignores/exports,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Add git aliases from gitconfig
for al in `git --list-cmds=alias`; do
    alias g$al="git $al"
done

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

export ASDF_DIR="${HOME}/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/usr/local/opt/python@3.7/bin:$PATH"

export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Google Cloud SDK
if [ -f '/Users/bthng/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/bthng/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/bthng/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/bthng/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="$PATH:/Users/bthng/.local/bin"

[[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"
export PATH="$HOME/.local/bin:$PATH"

export PATH="/Users/bthng/.antigravity/antigravity/bin:$PATH"

# pnpm
export PNPM_HOME="/Users/bthng/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Added by dbt Fusion extension
alias dbtf=/Users/bthng/.local/bin/dbt

# opencode
export PATH=/Users/bthng/.opencode/bin:$PATH

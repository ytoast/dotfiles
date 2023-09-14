eval "$(/opt/homebrew/bin/brew shellenv)"

# pyenv virtualenv is flaky, do not use
# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

if [ -f ~/.zshrc ]; then
    source ~/.zshrc
fi

# added by Snowflake SnowSQL installer v1.2
export PATH=/Applications/SnowSQL.app/Contents/MacOS:$PATH

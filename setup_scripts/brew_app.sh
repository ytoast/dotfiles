#!/usr/bin/env bash

# Misc casks
brew install --cask alfred
brew install --cask karabiner-elements
brew install --cask google-chrome
brew install --cask notion
brew install --cask spotify
brew install --cask obsidian
brew install --cask visual-studio-code
brew install --cask hiddenbar
brew install --cask rectangle
brew install --cask alacritty
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
brew install --cask docker
brew install --cask snowflake-snowsql

# Packages
brew install 1password-cli
brew install asdf
brew install entr
brew install fd
brew install fd
brew install fx
brew install fzf
brew install gh
brew install git-delta
brew install gnupg
brew install jenv
brew install jq
brew install lazygit
brew install lsd
brew install mas
brew install neovim
brew install npm
brew install pre-commit
brew install rg
brew install starship
brew install stow
brew install tig
brew install tmate
brew install tmuxinator
brew install ykman
brew install yq
brew install zoxide

# Install mac apps
# mas signin mas@example.com
mas install 1480933944  # Vimari
mas install 747648890   # Telegram
mas install 803453959   # Slack
mas install 1510445899  # Meeter
mas install 937984704   # Amphetamine
mas install 1569813296  # 1Password

# Git
brew tap microsoft/git
brew install --cask git-credential-manager-core

# Tap
brew tap hashicorp/tap
brew install hashicorp/tap/terraform

# fzf keybindings
$(brew --prefix)/opt/fzf/install

brew install charmbracelet/tap/crush

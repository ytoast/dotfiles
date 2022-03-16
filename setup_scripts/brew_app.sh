#!/usr/bin/env bash

# Misc casks
# brew install --cask alfred
brew install --cask karabiner-elements
# brew install --cask google-chrome
# brew install --cask notion
# brew install --cask spotify
# brew install --cask obsidian
# brew install --cask visual-studio-code
# brew install --cask hiddenbar
# brew install --cask rectangle
# brew install --cask alacritty
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

# Packages
# brew install entr
# brew install exa
# brew install fzf
# brew install gh
# brew install gnupg
# brew install jenv
# brew install jq
# brew install mas
# brew install neovim
# brew install pre-commit
# brew install rg
# brew install stow
# brew install tig
# brew install tmate
brew install tmuxinator
# brew install yq
# brew intall npm

# Install mac apps
# mas signin mas@example.com
# mas install 1480933944  # Vimari
# mas install 747648890   # Telegram
# mas install 803453959   # Slack
# mas install 1306893526    # Sorted3
# mas install 1510445899    # Meeter
# mas install 937984704     # Amphetamine

# Tap
# brew tap hashicorp/tap
# brew install hashicorp/tap/terraform

# fzf keybindings
$(brew --prefix)/opt/fzf/install

# refactor this to another file
# install pyright
npm i -g pyright

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install ohmyzsh - Do this with care
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Install ohmyzsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

# Install apps
./brew_app.sh
./npm_app.sh

# Needed to create links
sudo chown -R $(whoami) /usr/local/*

brew link starship
brew link zoxide

# Mac defaults
sh ~/dotfiles/macos.sh

# Install AWS CLI
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /

# Yubikeys: disable OTP option
ykman config mode FIDO+CCID

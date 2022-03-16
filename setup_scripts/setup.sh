# Install Brew
# curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
# echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/bthng/.zprofile
# eval "$(/opt/homebrew/bin/brew shellenv)"

# Install ohmyzsh - Do this with care
curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
cp ~/.zshrc.pre-oh-my-zsh ~/.zshrc

# Install ohmyzsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/asdf-vm/asdf.git ~/.asdf

# Install brew apps
# ./brew_app.sh

# Needed to create links
# sudo chown -R $(whoami) /usr/local/*

# brew link starship
# brew link zoxide

# Mac defaults
# sh ~/dotfiles/macos.sh


# Install AWS CLI
# curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
# sudo installer -pkg AWSCLIV2.pkg -target /

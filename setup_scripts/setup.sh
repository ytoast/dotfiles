# Install Brew
# curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
# echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/bthng/.zprofile
# eval "$(/opt/homebrew/bin/brew shellenv)"

# Install ohmyzsh - don't do this
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install brew apps
./brew_app.sh

# Needed to create links
sudo chown -R $(whoami) /usr/local/*

brew link starship
brew link zoxide

# Mac defaults
sh ~/dotfiles/macos.sh


# Install AWS CLI
# curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
# sudo installer -pkg AWSCLIV2.pkg -target /

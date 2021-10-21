# Needed to create links
sudo chown -R $(whoami) /usr/local/*

brew link starship
brew link zoxide

# Mac defaults
sh ~/dotfiles/macos.sh


# Install AWS CLI
curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg"
sudo installer -pkg AWSCLIV2.pkg -target /

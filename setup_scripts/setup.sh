# Needed to create links
sudo chown -R $(whoami) /usr/local/*

brew link starship
brew link zoxide

# Mac defaults
sh ~/dotfiles/macos.sh

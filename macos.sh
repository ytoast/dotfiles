# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder Enable text selection in quick look window
defaults write com.apple.finder QLEnableTextSelection -bool TRUE;killall Finder

# Dock: Place dock on the left
defaults write com.apple.dock "orientation" -string "left" && killall Dock

# Dock: Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Control Center: Show battery percentage
defaults write com.apple.controlcenter.plist BatteryShowPercentage -bool true

# Screencapture: Save screenshots to the desktop
mkdir "$HOME/Desktop/Screenshots"
defaults write com.apple.screencapture location -string "$HOME/Desktop/Screenshots"

# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Set a blazingly fast keyboard repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Holding down a character key will repeat the character:
defaults write -g ApplePressAndHoldEnabled -bool false


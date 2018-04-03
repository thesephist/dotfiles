# a set of commands to set up macOS devices

# please run macinit.sh _after_ Dropbox has been set up and sync'd

# install xcode tools
xcode-select --install

# install homebrew and doctor it
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor

# install packages and update / upgrade
brew update && brew upgrade
brew install zsh git vim emacs wget nodejs npm ruby python python3 youtube-dl golang make htop tmux gcc

# install global npm packages
sudo npm i -g pm2 yarn json-server gulp surge node-static

# configure shell
chsh -s /bin/zsh

# macOS custom configurations
#   set default TextEdit to start on plaintext, not rich text
defaults write com.apple.TextEdit RichText -int 0
#   resize and configure dock
defaults write com.apple.dock tilesize -int 0 && \
defaults write com.apple.Dock autohide-delay -float 0 && \
killall Dock
#   show all file extensions
defaults write -g AppleShowAllExtensions -bool true
#   show hidden files
defaults write com.apple.finder AppleShowAllFiles true
#   expand save panel by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true && \
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
#   show scrollbar only when it makes sense
defaults write -g AppleShowScrollBars -string "WhenScrolling"
#   prefer disk over iCloud
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false
#   default Finder location is $HOME
defaults write com.apple.finder NewWindowTarget -string "PfLo" && \
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
#   key repeat behaviors
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool true
defaults write -g KeyRepeat -int 0.02
#   screenshots to ~/Dropbox/Screenshots/
defaults write com.apple.screencapture location ~/Dropbox/Screenshots && \
killall SystemUIServer
#   update software as available
sudo softwareupdate -ia

# DONE
echo 'MacInit procedure complete!'


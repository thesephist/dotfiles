#!/bin/bash

# Run as your normal user, not superuser/admin
set -euo pipefail
trap 'printf "macinit failed at line %s\n" "$LINENO" >&2' ERR

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if [[ "$(uname -s)" != Darwin || "$(uname -m)" != arm64 || "$EUID" -eq 0 ]]; then
    echo "Run macinit natively on Apple Silicon as your normal user, not with sudo." >&2
    exit 1
fi

# Install Command Line Tools only, never full Xcode. The GUI installer is
# asynchronous: stop here and let the user rerun after it finishes.
if ! xcode-select -p >/dev/null 2>&1 || ! xcrun --find clang >/dev/null 2>&1; then
    xcode-select --install
    echo "Finish installing Command Line Tools, then rerun this script."
    exit 1
fi

# Install native Apple Silicon Homebrew.
brew_bin=/opt/homebrew/bin/brew
if [[ ! -x "$brew_bin" ]]; then
    installer="$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    /bin/bash -c "$installer"
fi
brew_env="$("$brew_bin" shellenv bash)"
eval "$brew_env"

# Doctor warnings are advisory; actual installation failures stop the script.
if ! brew doctor; then
    echo "Homebrew doctor reported warnings; review them above." >&2
fi
brew update
brew upgrade
brew bundle install --file="$SCRIPT_DIR/Brewfile"

# Back up and install only the Fish config, leaving other Fish files alone.
fish_config_dir="${XDG_CONFIG_HOME:-$HOME/.config}/fish"
if [[ -f "$fish_config_dir/config.fish" ]]; then
    cp -p "$fish_config_dir/config.fish" "$fish_config_dir/config.fish.backup.$(date +%Y%m%d%H%M%S).$$"
fi
mkdir -p "$fish_config_dir"
cp "$SCRIPT_DIR/config.fish" "$fish_config_dir/config.fish"

fish_bin=/opt/homebrew/bin/fish
if ! grep -Fxq "$fish_bin" /etc/shells; then
    printf '%s\n' "$fish_bin" | sudo tee -a /etc/shells >/dev/null
fi
current_shell="$(dscl . -read "/Users/$(id -un)" UserShell)"
if [[ "$current_shell" != "UserShell: $fish_bin" ]]; then
    chsh -s "$fish_bin"
fi

# macOS custom configurations
#   set default TextEdit to start on plaintext, not rich text
defaults write com.apple.TextEdit RichText -int 0
#   resize and configure dock
defaults write com.apple.dock tilesize -int 18
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock show-recents -bool false
#   show all file extensions
defaults write -g AppleShowAllExtensions -bool true
#   show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true
#   expand save panel by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true
#   match this machine's mouse scaling
defaults write -g com.apple.mouse.scaling -float 1
#   show scrollbar only when it makes sense
defaults write -g AppleShowScrollBars -string "WhenScrolling"
#   prefer disk over iCloud
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false
#   default Finder location is $HOME, using column view
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
#   key repeat behaviors
defaults write -g ApplePressAndHoldEnabled -bool false
#   preserve extremely fast repeat (-int 0.02 stores 0; behavior is undocumented)
defaults write -g KeyRepeat -int 0.02
defaults write -g InitialKeyRepeat -int 15
#   disable typographical assistance
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write -g NSAutomaticCapitalizationEnabled -bool false
#   screenshots to ~/Downloads
mkdir -p "$HOME/Downloads"
defaults write com.apple.screencapture location -string "$HOME/Downloads"

# Apply preferences after all writes. These processes may not be running.
killall Dock || true
killall Finder || true
killall SystemUIServer || true

#   update software as available
sudo softwareupdate -ia

# DONE
echo 'MacInit procedure complete! Log out and back in to use Fish and all preferences.'


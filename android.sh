#!/usr/bin/env bash

# Install Android development tools
# Updated for current versions and ARM Mac compatibility

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Make sure we're using the latest Homebrew.
brew update

echo "Installing Android development tools..."

# Install Java (required for Android development)
brew install --cask temurin          # Eclipse Temurin (OpenJDK)

# Install Android Studio (includes Android SDK)
brew install --cask android-studio

# Install IntelliJ IDEA Community Edition (optional)
brew install --cask intellij-idea-ce

# Install Android SDK command line tools
# Note: Android Studio now includes the SDK, but you can install separately if needed
# brew install --cask android-sdk

# Install Android platform tools (adb, fastboot, etc.)
brew install --cask android-platform-tools

# Install useful Android development tools
brew install scrcpy                  # Display and control Android devices

# Remove outdated versions from the cellar.
brew cleanup

echo "------------------------------"
echo "Android development tools installation complete!"
echo ""
echo "Next steps:"
echo "1. Open Android Studio and complete the setup wizard"
echo "2. Install Android SDK components via Android Studio SDK Manager"
echo "3. Configure environment variables in ~/.extra:"
echo "   export ANDROID_HOME=\$HOME/Library/Android/sdk"
echo "   export PATH=\$PATH:\$ANDROID_HOME/emulator"
echo "   export PATH=\$PATH:\$ANDROID_HOME/platform-tools"

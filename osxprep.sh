#!/usr/bin/env bash

# macOS Preparation Script
# Updated for modern macOS (Big Sur, Monterey, Ventura, Sonoma and later)
# Works on both Intel and Apple Silicon Macs

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Step 1: Update the OS and Install Xcode Tools
echo "------------------------------"
echo "Updating macOS. If this requires a restart, run the script again."
# Install all available updates
sudo softwareupdate -ia --verbose
# Install only recommended available updates
#sudo softwareupdate -ir --verbose

echo "------------------------------"
echo "Installing Xcode Command Line Tools."
# Install Xcode command line tools
# The --install flag will prompt for installation if not already installed
xcode-select --install 2>/dev/null || echo "Xcode Command Line Tools already installed"

# Accept Xcode license if needed
if [ -d "/Applications/Xcode.app" ]; then
  sudo xcodebuild -license accept 2>/dev/null || true
fi

echo "------------------------------"
echo "macOS preparation complete!"
echo "You can now run brew.sh to install Homebrew and packages."

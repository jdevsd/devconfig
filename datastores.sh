#!/usr/bin/env bash

# Install databases and data stores
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

# Install data stores
echo "Installing databases and data stores..."

# SQL Databases
brew install mysql
brew install postgresql@15

# NoSQL Databases
brew install mongodb-community      # MongoDB
brew install redis                  # Redis

# Search and Analytics
# Note: Elasticsearch now requires manual download due to licensing changes
# brew install elasticsearch

# Modern alternatives
brew install sqlite                 # Lightweight SQL database

# Optional: GUI tools
echo "Installing database GUI tools..."
brew install --cask mysqlworkbench
brew install --cask pgadmin4       # PostgreSQL GUI
# brew install --cask mongodb-compass  # MongoDB GUI
# brew install --cask redisinsight     # Redis GUI
brew install --cask tableplus      # Universal database tool

# Database CLI tools
brew install usql                  # Universal SQL CLI

# Start services (optional - uncomment to auto-start)
# brew services start mysql
# brew services start postgresql@15
# brew services start mongodb-community
# brew services start redis

# Remove outdated versions from the cellar.
brew cleanup

echo "------------------------------"
echo "Database installation complete!"
echo "To start services:"
echo "  MySQL:      brew services start mysql"
echo "  PostgreSQL: brew services start postgresql@15"
echo "  MongoDB:    brew services start mongodb-community"
echo "  Redis:      brew services start redis"
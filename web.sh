#!/usr/bin/env bash

# Install modern web development tools
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

# Install Node.js (includes npm)
brew install node

# Remove outdated versions from the cellar.
brew cleanup

# Install modern web development tools globally
npm install -g typescript        # TypeScript compiler
npm install -g tsx                # TypeScript runner
npm install -g eslint             # Modern linter (replaces jshint)
npm install -g prettier           # Code formatter
npm install -g vite               # Modern build tool
npm install -g webpack            # Module bundler
npm install -g npm-check-updates  # Update npm dependencies
npm install -g pnpm               # Fast package manager
npm install -g yarn               # Alternative package manager
npm install -g vercel             # Deployment platform CLI
npm install -g netlify-cli        # Netlify CLI

# Optional: Install Ruby and Jekyll for static sites
# brew install ruby
# gem install jekyll bundler

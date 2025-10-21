#!/usr/bin/env bash

# Install command-line tools using Homebrew.
# Updated for ARM Mac (Apple Silicon) compatibility

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

# Detect Homebrew prefix (ARM Mac uses /opt/homebrew, Intel Mac uses /usr/local)
BREW_PREFIX=$(brew --prefix)

# Make sure we're using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with macOS are outdated).
# Don't forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
# Create symlink if it doesn't exist
if [ ! -f "$BREW_PREFIX/bin/sha256sum" ]; then
  ln -s "$BREW_PREFIX/bin/gsha256sum" "$BREW_PREFIX/bin/sha256sum"
fi

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed
# Install modern Bash (macOS ships with Bash 3.2)
brew install bash
brew install bash-completion@2
# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
BREW_BASH="$BREW_PREFIX/bin/bash"
if ! grep -q "$BREW_BASH" /etc/shells; then
  sudo bash -c "echo $BREW_BASH >> /etc/shells"
  # Change to the new shell, prompts for password
  chsh -s "$BREW_BASH"
fi

# Install `wget` with IRI support.
brew install wget

# Install Python (Python 3 is the default now)
brew install python@3.11

# Install ruby-build and rbenv
brew install ruby-build
brew install rbenv
LINE='eval "$(rbenv init -)"'
grep -q "$LINE" ~/.extra || echo "$LINE" >> ~/.extra

# Install more recent versions of some macOS tools.
brew install vim
brew install grep
brew install openssh
brew install screen
brew install gpg

# Install font tools.
brew install woff2

# Install security and network tools.
brew install aircrack-ng
brew install bfg
brew install binutils
brew install binwalk
brew install fcrackzip
brew install foremost
brew install hashpump
brew install hydra
brew install john
brew install netpbm
brew install nmap
brew install pngcheck
brew install socat
brew install sqlmap
brew install tcpflow
brew install tcpreplay
brew install tcptrace
brew install xz

# Install other useful binaries.
brew install ack
brew install exiv2
brew install git
brew install git-lfs
brew install git-flow
brew install git-extras
brew install gh  # GitHub CLI (replaces hub)
brew install imagemagick
brew install lua
brew install lynx
brew install p7zip
brew install pigz
brew install pv
brew install rename
brew install speedtest-cli
brew install ssh-copy-id
brew install tree
brew install webkit2png
brew install zopfli
brew install pkg-config
brew install libffi
brew install pandoc
brew install jq  # JSON processor
brew install htop  # Better top
brew install tldr  # Simplified man pages
brew install ripgrep  # Fast grep alternative
brew install fd  # Fast find alternative
brew install bat  # Better cat
brew install exa  # Better ls

# Lxml and Libxslt
brew install libxml2
brew install libxslt

# Install Heroku CLI
brew tap heroku/brew
brew install heroku

# Install Node.js and npm
brew install node

# Install modern shell tools
brew install zsh
brew install zsh-completions
brew install zsh-syntax-highlighting

# Core casks (GUI applications)
brew install --cask alfred
brew install --cask iterm2
brew install --cask temurin  # Java (OpenJDK)
brew install --cask xquartz

# Development tool casks
brew install --cask visual-studio-code  # Modern alternative to Sublime/Atom
brew install --cask sublime-text
# brew install --cask virtualbox  # Not natively supported on ARM Mac yet
# brew install --cask vagrant     # Requires VirtualBox
brew install --cask macdown

# Misc casks
brew install --cask google-chrome
brew install --cask firefox
brew install --cask slack
brew install --cask dropbox
# brew install --cask 1password  # Now requires subscription
# brew install --cask gimp
# brew install --cask inkscape

# Remove comment to install LaTeX distribution MacTeX
# brew install --cask mactex

# Install Docker Desktop (native ARM support, no VirtualBox needed)
brew install --cask docker

# Install developer friendly quick look plugins; see https://github.com/sindresorhus/quick-look-plugins
brew install --cask qlcolorcode
brew install --cask qlstephen
brew install --cask qlmarkdown
brew install --cask quicklook-json
brew install --cask qlimagesize
brew install --cask suspicious-package
brew install --cask qlvideo
brew install --cask webpquicklook

# Remove outdated versions from the cellar.
brew cleanup

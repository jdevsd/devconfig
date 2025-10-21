#!/usr/bin/env bash

# Bootstrap script to sync dotfiles
# Updated for modern usage

cd "$(dirname "${BASH_SOURCE}")";

# Try to pull from the default branch (could be main or master)
git pull origin main 2>/dev/null || git pull origin master 2>/dev/null || echo "Could not pull from remote. Using local files."

function doIt() {
    # Sync dotfiles to home directory
    rsync --exclude ".git/" \
        --exclude ".gitignore" \
        --exclude ".DS_Store" \
        --exclude "bootstrap.sh" \
        --exclude "README.md" \
        --exclude "CREDITS.md" \
        --exclude "LICENSE" \
        --exclude "*.sh" \
        --exclude "bin/" \
        --exclude "init/" \
        -avh --no-perms . ~;

    # Source the bash profile to apply changes
    if [ -f ~/.bash_profile ]; then
        source ~/.bash_profile;
    elif [ -f ~/.bashrc ]; then
        source ~/.bashrc;
    fi

    echo "Dotfiles synced successfully!"
}

if [ "$1" == "--force" ] || [ "$1" == "-f" ]; then
    doIt;
else
    read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
    echo "";
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        doIt;
    fi;
fi;
unset doIt;

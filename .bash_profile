# Add Homebrew to PATH (ARM Mac uses /opt/homebrew, Intel Mac uses /usr/local)
if [ -d "/opt/homebrew" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -d "/usr/local/Homebrew" ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Add GNU coreutils to PATH
if type brew &>/dev/null; then
  BREW_PREFIX=$(brew --prefix)
  # GNU core utilities
  export PATH="$BREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
  # GNU find, locate, updatedb, and xargs
  export PATH="$BREW_PREFIX/opt/findutils/libexec/gnubin:$PATH"
  # GNU sed
  export PATH="$BREW_PREFIX/opt/gnu-sed/libexec/gnubin:$PATH"
fi

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
    shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if type brew &>/dev/null; then
  BREW_PREFIX=$(brew --prefix)
  # Try bash-completion@2 first (recommended)
  if [ -r "$BREW_PREFIX/etc/profile.d/bash_completion.sh" ]; then
    source "$BREW_PREFIX/etc/profile.d/bash_completion.sh"
  # Fall back to bash-completion@1
  elif [ -f "$BREW_PREFIX/etc/bash_completion" ]; then
    source "$BREW_PREFIX/etc/bash_completion"
  fi
elif [ -f /etc/bash_completion ]; then
  source /etc/bash_completion
fi

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null; then
  complete -o default -o nospace -F _git g
fi

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

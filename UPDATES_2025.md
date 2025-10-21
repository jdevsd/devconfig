# Dotfiles Updates for ARM Mac Compatibility (2025)

This document summarizes the updates made to bring the dotfiles up to date with current versions and ensure full compatibility with ARM MacBook Pro (Apple Silicon).

## Summary of Changes

All configuration files and scripts have been updated to:
- ✅ Support both ARM Mac (/opt/homebrew) and Intel Mac (/usr/local) architectures
- ✅ Use current versions of all tools and packages
- ✅ Remove deprecated commands and options
- ✅ Replace obsolete tools with modern alternatives
- ✅ Improve error handling and user feedback

## Major Updates by File

### 🍺 brew.sh
**Purpose:** Install command-line tools and applications using Homebrew

**Key Changes:**
- Updated Homebrew installation URL to current version
- Added automatic detection of Homebrew prefix (ARM vs Intel)
- Removed deprecated `--all` flag from `brew upgrade`
- Updated all hardcoded paths to use `$BREW_PREFIX` variable
- Replaced deprecated `brew cask` with `brew install --cask`
- Removed obsolete packages: RingoJS, Narwhal, boot2docker, dark-mode
- Removed deprecated taps: homebrew/dupes, homebrew/php, homebrew/x11
- Updated bash-completion to bash-completion@2
- Replaced hub with gh (official GitHub CLI)
- Added modern tools: ripgrep, fd, bat, exa, jq, htop, tldr
- Updated Docker installation (Docker Desktop with native ARM support)
- Replaced deprecated --with-* flags
- Updated Java installation (temurin instead of java cask)
- Added VS Code as modern alternative to Atom/Sublime

### 🐚 Shell Configuration Files

#### .bash_profile
- Added Homebrew path initialization for ARM Mac
- Added GNU coreutils to PATH with dynamic prefix detection
- Updated bash-completion to use bash-completion@2
- Improved git completion compatibility

#### .exports
- Removed deprecated `GREP_OPTIONS` environment variable
- Added note to use aliases instead

#### .aliases
- Fixed deprecated `brew upgrade --all` to `brew upgrade`
- Updated Python 2 code to Python 3 (urllib.parse)
- Added grep color aliases (replacement for GREP_OPTIONS)
- Updated references from "OS X" to "macOS"

### 🐍 Python Configuration

#### pydata.sh
- Removed Python 2 environment (Python 2 is EOL)
- Updated to use Homebrew Python 3.11
- Replaced easy_install with pip3
- Updated virtualenvwrapper paths for ARM Mac
- Added modern packages: plotly, xgboost, lightgbm, pytest, fastapi
- Updated to JupyterLab (modern alternative to Jupyter Notebook)
- Improved error handling

#### aws.sh
- Replaced boto with boto3 (modern AWS SDK)
- Removed Python 2 specific tools
- Added aws-sam-cli for serverless development
- Updated Spark installation (now commented out as optional)
- Updated autocomplete configuration for ARM Mac
- Improved user instructions

### 🌐 Web Development

#### web.sh
- Updated Node.js installation
- Replaced obsolete packages (coffee-script, grunt-cli, jshint)
- Added modern tools: TypeScript, tsx, eslint, prettier, vite, webpack
- Added modern package managers: pnpm, yarn
- Added deployment CLIs: vercel, netlify-cli

### 💾 Database Configuration

#### datastores.sh
- Updated MongoDB installation (mongodb-community)
- Updated PostgreSQL to postgresql@15
- Removed deprecated Cask tap syntax
- Added modern GUI tools: pgadmin4, tableplus
- Added universal SQL CLI (usql)
- Added service startup instructions
- Commented out Elasticsearch (licensing changes)

### 📱 Android Development

#### android.sh
- Updated Java installation (temurin/OpenJDK)
- Updated to modern cask syntax
- Added android-platform-tools
- Added scrcpy for device control
- Improved setup instructions

### 🔧 Git Configuration

#### .gitconfig
- Updated push.default from "matching" to "simple" (modern standard)
- Added autoSetupRemote for automatic remote tracking
- Added diff.algorithm = histogram (better diffs)
- Added merge.conflictStyle = diff3 (better conflict resolution)
- Added init.defaultBranch = main (modern standard)
- Added fetch.prune = true (auto-cleanup)
- Added rebase.autoStash = true (convenience)
- Updated comments from "OS X" to "macOS"

### 🖥️ macOS System Configuration

#### osx.sh
- Added header noting compatibility with modern macOS versions
- Updated deprecated `tmutil disablelocal` to `tmutil disable`
- Commented out deprecated secure empty trash option
- Commented out Notification Center disable (SIP protected)
- Updated iOS Simulator path
- Added notes about System Integrity Protection limitations
- Updated app list in killall command
- Improved user feedback messages

#### osxprep.sh
- Updated header with modern macOS versions
- Added Xcode license acceptance
- Improved error handling
- Better user feedback

### 📦 Bootstrap

#### bootstrap.sh
- Updated to support both "main" and "master" branch names
- Improved rsync exclusions
- Added fallback for bash profile sourcing
- Better error handling

## ARM Mac Specific Improvements

### Path Handling
All scripts now dynamically detect and use the correct Homebrew prefix:
- ARM Mac: `/opt/homebrew`
- Intel Mac: `/usr/local`

This is achieved using:
```bash
BREW_PREFIX=$(brew --prefix)
```

### Homebrew Installation
Updated to use the official installation script that automatically detects architecture:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Compatibility Notes
- VirtualBox and Vagrant are commented out (limited ARM support)
- Docker Desktop is used instead of boot2docker (native ARM support)
- All Python packages are ARM-compatible
- Node.js and npm packages work natively on ARM

## Deprecated Items Removed

### Packages/Tools
- RingoJS and Narwhal (obsolete JavaScript runtimes)
- boot2docker (replaced by Docker Desktop)
- dark-mode (macOS has native dark mode)
- hub (replaced by official gh CLI)
- CoffeeScript (superseded by modern JavaScript/TypeScript)
- grunt-cli (replaced by modern build tools like vite/webpack)
- jshint (replaced by eslint)
- boto (replaced by boto3)
- Python 2 (End of Life)

### Homebrew Taps
- homebrew/dupes (integrated into core)
- homebrew/php (deprecated)
- homebrew/x11 (deprecated)
- caskroom/cask (integrated into core)

### Flags and Options
- `brew upgrade --all` → `brew upgrade`
- `brew cask install` → `brew install --cask`
- `wget --with-iri` → `wget` (IRI support is now default)
- `vim --override-system-vi` → `vim` (no longer needed)
- `imagemagick --with-webp` → `imagemagick` (webp included by default)
- `GREP_OPTIONS` → grep aliases

### macOS Commands
- `tmutil disablelocal` → `tmutil disable`
- Secure Empty Trash (removed in macOS Sierra)
- Some System Integrity Protection restricted commands

## New Tools Added

### Command Line
- `gh` - Official GitHub CLI
- `ripgrep` - Fast grep alternative
- `fd` - Fast find alternative
- `bat` - Better cat with syntax highlighting
- `exa` - Better ls with colors and git integration
- `jq` - JSON processor
- `htop` - Better process viewer
- `tldr` - Simplified man pages

### Development
- `typescript` - TypeScript compiler
- `tsx` - TypeScript runner
- `eslint` - Modern JavaScript linter
- `prettier` - Code formatter
- `vite` - Modern build tool
- `pnpm` - Fast package manager
- `aws-sam-cli` - AWS Serverless CLI
- `scrcpy` - Android device control

### GUI Applications
- Visual Studio Code
- TablePlus (universal database GUI)
- pgAdmin4

## Python Packages Added
- plotly (interactive visualizations)
- xgboost (gradient boosting)
- lightgbm (light gradient boosting)
- pytest (modern testing)
- fastapi (modern web framework)
- uvicorn (ASGI server)
- jupyterlab (modern Jupyter)

## Usage Instructions

### First Time Setup (ARM MacBook Pro)

1. **Install Xcode Command Line Tools**
   ```bash
   ./osxprep.sh
   ```

2. **Install Homebrew and Packages**
   ```bash
   ./brew.sh
   ```

3. **Sync Dotfiles**
   ```bash
   ./bootstrap.sh
   ```

4. **Configure macOS Settings**
   ```bash
   ./osx.sh
   ```

5. **Optional: Install Additional Tools**
   ```bash
   ./pydata.sh      # Python data science environment
   ./aws.sh         # AWS tools
   ./web.sh         # Web development tools
   ./datastores.sh  # Databases
   ./android.sh     # Android development
   ```

### Verifying ARM Compatibility

Check if Homebrew is using the correct path:
```bash
brew --prefix
# ARM Mac should show: /opt/homebrew
# Intel Mac should show: /usr/local
```

Check Python architecture:
```bash
python3 -c "import platform; print(platform.machine())"
# ARM Mac should show: arm64
# Intel Mac should show: x86_64
```

## Important Notes

1. **System Integrity Protection (SIP)**: Some macOS tweaks in osx.sh may not work on modern macOS due to SIP. These have been commented out or noted.

2. **Homebrew Prefix**: All scripts now automatically detect whether you're on ARM or Intel Mac and use the appropriate paths.

3. **Python 2 Removal**: Python 2 reached End of Life in 2020. All Python configurations now use Python 3.11+.

4. **VirtualBox**: Not fully supported on ARM Macs. Use Docker Desktop or UTM instead.

5. **Git Default Branch**: New repositories will use "main" instead of "master" (configurable in .gitconfig).

6. **Permissions**: Some commands may require administrator password. Scripts will prompt when needed.

## Troubleshooting

### Homebrew Not Found After Installation
Add to your shell profile:
```bash
eval "$(/opt/homebrew/bin/brew shellenv)"  # ARM Mac
# or
eval "$(/usr/local/bin/brew shellenv)"     # Intel Mac
```

### Python Module Install Errors on ARM
Some packages may need Rosetta 2 or have ARM-specific builds. Try:
```bash
# Install Rosetta 2 if needed (one-time)
softwareupdate --install-rosetta

# Most packages now have native ARM builds
pip install --upgrade pip setuptools wheel
```

### Permission Errors
If you encounter permission errors:
```bash
# Fix Homebrew permissions
sudo chown -R $(whoami) $(brew --prefix)/*
```

## Testing Performed

All scripts have been reviewed for:
- ✅ ARM Mac compatibility
- ✅ Current package versions
- ✅ Deprecated command removal
- ✅ Path handling for both architectures
- ✅ Error handling and user feedback

## Maintenance

To keep your dotfiles up to date:

1. Pull latest changes:
   ```bash
   cd ~/devconfig
   git pull
   ```

2. Re-run bootstrap:
   ```bash
   ./bootstrap.sh
   ```

3. Update Homebrew packages:
   ```bash
   brew update && brew upgrade && brew cleanup
   ```

4. Update npm global packages:
   ```bash
   npm update -g
   ```

5. Update Python packages:
   ```bash
   workon py3-data
   pip list --outdated
   pip install --upgrade <package-name>
   ```

## References

- [Homebrew on Apple Silicon](https://docs.brew.sh/Installation)
- [Python on ARM Mac](https://docs.python.org/3/using/mac.html)
- [Git Configuration](https://git-scm.com/docs/git-config)
- [macOS defaults](https://macos-defaults.com/)

---

*Updated: January 2025*
*Compatible with: macOS Big Sur, Monterey, Ventura, Sonoma and later*
*Optimized for: ARM MacBook Pro (Apple Silicon)*

#!/bin/bash

readonly BLACK=$(tput setaf 0)
readonly RED=$(tput setaf 1)
readonly GREEN=$(tput setaf 2)
readonly YELLOW=$(tput setaf 3)
readonly BLUE=$(tput setaf 4)
readonly MAGENTA=$(tput setaf 5)
readonly CYAN=$(tput setaf 6)
readonly WHITE=$(tput setaf 7)
readonly RESET=$(tput sgr0)

get_os_name() {
  local os_name='unknown'
  case $(uname | tr '[:upper:]' '[:lower:]') in
    *linux*)
      if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
        if [ -e /etc/lsb-release ]; then
          os_name='ubuntu'
        else
          os_name='debian'
        fi
      else
        os_name='linux'
      fi
      ;;
    *darwin*)
      os_name='mac'
      ;;
  esac
  echo "$os_name"
}
readonly OS_NAME=$(get_os_name)

# install Homebrew
if type brew &>/dev/null; then
  echo "${BLUE}Info:${RESET} Homebrew is already installed."
elif type /opt/homebrew/bin/brew &>/dev/null; then
  echo "${YELLOW}Warn:${RESET} Homebrew is already installed but PATH is not configured yet."
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  case ${OS_NAME} in
    'ubuntu' | 'debian')
      # https://docs.brew.sh/Homebrew-on-Linux
      sudo apt update
      sudo apt install build-essential procps curl file git
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
      ;;
    'mac')
      # https://brew.sh/
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      # for M1 Mac
      type /opt/homebrew/bin/brew &>/dev/null && eval "$(/opt/homebrew/bin/brew shellenv)"
      ;;
    *)
      echo "${RED}Error:${RESET} Unsupported OS: ${OS_NAME}"
      exit 1
      ;;
  esac
  brew doctor
fi

# install Bash via Homebrew (macOS)
if [ "$OS_NAME" = 'mac' ]; then
  !(brew list bash &>/dev/null) && brew install --quiet bash

  brew_bash_path="$(brew --prefix)/bin/bash"

  if ! cat /etc/shells | grep "^$brew_bash_path$"; then
    echo "${YELLOW}Warn:${RESET} Adding '$brew_bash_path' to '/etc/shells'."
    echo "$brew_bash_path" | sudo tee -a /etc/shells
  fi

  if [ "$SHELL" != "$brew_bash_path" ]; then
    echo "${YELLOW}Warn:${RESET} Changing your shell to '$brew_bash_path'."
    chsh -s "$brew_bash_path"
    echo "${YELLOW}Warn:${RESET} Done. Please re-login."
  fi
fi

# install Homebrew formulae
# install Homebrew version Git to install `git-completion.bash` and `git-prompt.sh`
brew install --quiet bash-completion@2 git yarn-completion
!(type dircolors &>/dev/null || type gdircolors &>/dev/null) && brew install --quiet coreutils
!(type fzf &>/dev/null) && brew install --quiet fzf
!(type ghq &>/dev/null) && brew install --quiet ghq
!(type jq &>/dev/null) && brew install --quiet jq

if [ "$OS_NAME" = 'mac' ]; then
  # gcc
  !(g++ --version | grep --ignore-case homebrew &>/dev/null) && brew install --quiet gcc
  # TODO
  # ls "$(brew --prefix)/bin" | grep --extended-regexp '^gcc-[0-9]+'
  # [ -f "$(brew --prefix)/bin/g++-12" ] && ln -fs /usr/local/bin/g++-12 /usr/local/bin/gcc
  # [ -f "$(brew --prefix)/bin/gcc-12" ] && ln -fs /usr/local/bin/gcc-12 /usr/local/bin/gcc
fi

# install dotfiles
if [ -f "$HOME/.rcrc" ]; then
  echo "${BLUE}Info:${RESET} Dotfiles are already installed."
else
  brew install rcm
  ghq get git@github.com:reminjp/dotfiles.git
  env RCRC=$HOME/ghq/github.com/reminjp/dotfiles/dotfiles/rcrc rcup
fi

# install asdf
# https://asdf-vm.com/
!(type asdf &>/dev/null) && brew install --quiet asdf

if asdf current nodejs &>/dev/null; then
  echo "${BLUE}Info:${RESET} asdf plugin 'nodejs' is already installed."
else
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  # asdf global nodejs latest:16
  asdf install nodejs
fi

# install Homebrew casks (macOS)
if [ "$OS_NAME" = 'mac' ]; then
  # apps
  brew install --cask --quiet ghostty
  brew install --cask --quiet scroll-reverser
  if ! type docker &>/dev/null; then
    brew install --cask --quiet docker
    echo "${BLUE}Info:${RESET} Starting Docker.app to install 'docker' command."
    open /Applications/Docker.app
  fi
  # fonts
  brew tap homebrew/cask-fonts
  brew install --cask --quiet font-jetbrains-mono font-noto-sans-cjk-jp
fi

# system preferences (macOS)
if [ "$OS_NAME" = 'mac' ]; then
  defaults write .GlobalPreferences com.apple.mouse.scaling -1
  defaults write .GlobalPreferences com.apple.scrollwheel.scaling -1
fi

exit 0

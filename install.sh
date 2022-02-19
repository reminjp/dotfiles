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

# install Homebrew
if type brew &>/dev/null; then
  echo "${BLUE}Info:${RESET} Homebrew is already installed."
else
  declare os_name=$(get_os_name)
  case ${os_name} in
    'ubuntu' | 'debian')
      # https://docs.brew.sh/Homebrew-on-Linux
      sudo apt install build-essential curl file git
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
      ;;
    'mac')
      # https://brew.sh/
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      ;;
    *)
      echo "${RED}Error:${RESET} Unsupported OS: ${os_name}"
      exit 1
      ;;
  esac
  unset os_name
  brew doctor
fi

# install Homebrew formulae
[ ! -f "$(brew --prefix)/etc/bash_completion" ] && brew install bash-completion
!(type dircolors &>/dev/null || type gdircolors &>/dev/null) && brew install coreutils
!(type fzf &>/dev/null) && brew install fzf
!(type ghq &>/dev/null) && brew install ghq
!(type git &>/dev/null) && brew install git

# install dotfiles
if [ -f "$HOME/.rcrc" ]; then
  echo "${BLUE}Info:${RESET} Dotfiles are already installed."
else
  brew install rcm
  ghq get git@github.com:rdrgn/dotfiles.git
  env RCRC=$HOME/ghq/github.com/rdrgn/dotfiles/dotfiles/rcrc rcup
fi

# install asdf
# https://asdf-vm.com/
!(type asdf &>/dev/null) && brew install asdf

if asdf current nodejs &>/dev/null; then
  echo "${BLUE}Info:${RESET} asdf plugin 'nodejs' is already installed."
else
  asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  # asdf global nodejs latest:16
  asdf install nodejs
fi

exit 0

#!/bin/bash

cd $(dirname $0)
. ../util/color.sh
. ../util/os.sh

# Install Homebrew
if type brew >/dev/null 2>&1; then
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
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      ;;
    *)
      echo "${RED}Error:${RESET} Unsupported OS: ${os_name}"
      exit 1
      ;;
  esac
  unset os_name
fi

brew doctor

# Install Homebrew formulae
if [ ! -f "$(brew --prefix)/etc/bash_completion" ]; then
  brew install bash-completion
fi

if !(type dircolors >/dev/null 2>&1 || type gdircolors >/dev/null 2>&1); then
  brew install coreutils
fi

if !(type git >/dev/null 2>&1); then
  brew install git
fi

if !(type ghq > /dev/null 2>&1); then
  brew install ghq
fi

if !(type fzf > /dev/null 2>&1); then
  brew install fzf
fi

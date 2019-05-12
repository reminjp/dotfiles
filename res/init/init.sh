#!/bin/bash

cd $(dirname $0)
. ../util/colors.sh
. ../util/os.sh

# Install Homebrew
if type brew >/dev/null 2>&1; then
  echo "${BLUE}Info:${RESET} Homebrew is already installed."
else
  os_name=$(get_os_name)
  case ${os_name} in
    ubuntu | debian)
      # https://docs.brew.sh/Homebrew-on-Linux
      sudo apt install build-essential curl file git
      sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
      ;;
    mac)
      # https://brew.sh/
      /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      ;;
    *)
      echo "${RED}Error:${RESET} Unsupported OS: ${os_name}"
      exit 1
      ;;
  esac
fi

brew doctor

# Install Homebrew formulae
brew install git

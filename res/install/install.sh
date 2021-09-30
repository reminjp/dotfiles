#!/bin/bash

cd $(dirname $0)
. ../utils/color.sh
. ../utils/os.sh

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

# install Homebrew formulae
[ ! -f "$(brew --prefix)/etc/bash_completion" ] && brew install bash-completion
!(type dircolors &>/dev/null || type gdircolors &>/dev/null) && brew install coreutils
!(type git &>/dev/null) && brew install git
!(type ghq &>/dev/null) && brew install ghq
!(type fzf &>/dev/null) && brew install fzf

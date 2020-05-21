# run only if the shell is interactive
case $- in
  *i*) ;;
  *) return ;;
esac

# history
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# to check window size
shopt -s checkwinsize

# enable lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable bash completion
if ! shopt -oq posix; then
  if type brew &>/dev/null && [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  elif [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# prompt
__prompt_command() {
  # get the status first of all
  local status_code=$? status_name
  case $status_code in
    1) status_name='error' ;;
    2) status_name='builtin error' ;;
    126) status_name='not executable' ;;
    127) status_name='command not found' ;;
    128) status_name='SIGHUP' ;;
    129) status_name='SIGINT' ;;
    130) status_name='SIGQUIT' ;;
    131) status_name='SIGILL' ;;
    132) status_name='SIGTRAP' ;;
    133) status_name='SIGABRT' ;;
    134) status_name='SIGEMT' ;;
    135) status_name='SIGFPE' ;;
    136) status_name='SIGKILL' ;;
    137) status_name='SIGBUS' ;;
    138) status_name='SIGSEGV' ;;
    139) status_name='SIGSYS' ;;
    140) status_name='SIGPIPE' ;;
    141) status_name='SIGALRM' ;;
    142) status_name='SIGTERM' ;;
    143) status_name='SIGURG' ;;
    144) status_name='SIGSTOP' ;;
    145) status_name='SIGTSTP' ;;
    146) status_name='SIGCONT' ;;
    147) status_name='SIGCHLD' ;;
    148) status_name='SIGTTIN' ;;
    149) status_name='SIGTTOU' ;;
    150) status_name='SIGIO' ;;
    151) status_name='SIGXCPU' ;;
    152) status_name='SIGXFSZ' ;;
    153) status_name='SIGVTALRM' ;;
    154) status_name='SIGPROF' ;;
    155) status_name='SIGWINCH' ;;
    156) status_name='SIGINFO' ;;
    157) status_name='SIGUSR1' ;;
    158) status_name='SIGUSR2' ;;
  esac

  # colors
  local color_green color_blue color_warning color_red color_reset
  case "$TERM" in
    xterm-color | *-256color)
      color_red=$(tput setaf 1)$(tput bold)
      color_green=$(tput setaf 2)$(tput bold)
      color_yellow=$(tput setaf 3)$(tput bold)
      color_blue=$(tput setaf 4)$(tput bold)
      color_reset=$(tput sgr0)
      ;;
  esac

  # debian_chroot
  local debian_chroot
  if [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
  fi

  # update PS1
  PS1=''
  if [ $status_code -ne 0 ]; then
    PS1+="$color_red$status_code ($status_name)$color_reset\n"
  fi
  PS1+='${debian_chroot:+($debian_chroot)}'
  PS1+="$color_green\\u@\\h$color_reset:$color_blue\\w$color_reset"
  if type __git_ps1 &>/dev/null; then
    PS1+=$(__git_ps1 ":$color_yellow%s$color_reset")
  fi
  PS1+='\$ '
}
PROMPT_COMMAND=__prompt_command

# aliases
if type dircolors &>/dev/null; then
  [ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
if type gdircolors &>/dev/null; then
  [ -r ~/.dircolors ] && eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"
  alias ls='gls --color=auto'
  alias dir='gdir --color=auto'
  alias vdir='gvdir --color=auto'
fi

alias a='./a.out'
alias g++17='g++ -std=c++17'

# functions
repo() {
  local repository_name="$(ghq list | fzf --layout=reverse --preview="ls -a $(ghq root)/{}")"
  [ -n "$repository_name" ] && cd "$(ghq root)/$repository_name"
}

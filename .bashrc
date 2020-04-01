# If not running interactively, don't do anything.
case $- in
  *i*) ;;
  *) return ;;
esac

# History
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000

# Window size
shopt -s checkwinsize

# Enable lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable programmable completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Prompt
case "$TERM" in
  xterm-color | *-256color) color_prompt=yes ;;
esac
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi
if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
case "$TERM" in
  xterm* | rxvt*) PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1" ;;
esac
unset color_prompt debian_chroot

# Aliases
if type dircolors >/dev/null 2>&1; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi
if type gdircolors >/dev/null 2>&1; then
  test -r ~/.dircolors && eval "$(gdircolors -b ~/.dircolors)" || eval "$(gdircolors -b)"
  alias ls='gls --color=auto'
  alias dir='gdir --color=auto'
  alias vdir='gvdir --color=auto'
fi
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias a='./a.out'

# Functions
repo() {
  declare -r REPOSITORY_NAME="$(ghq list | fzf --layout=reverse --preview="ls -a $(ghq root)/{}")"
  [ -n "${REPOSITORY_NAME}" ] && cd "$(ghq root)/${REPOSITORY_NAME}"
}

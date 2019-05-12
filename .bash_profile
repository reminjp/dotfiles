if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Homebrew
if [ -d '/home/linuxbrew/.linuxbrew/bin' ]; then
  export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi
if [ -d "$HOME/.linuxbrew/bin" ]; then
  export PATH="$HOME/.linuxbrew/bin:$PATH"
fi

# Rust
if [ -d "$HOME/.cargo/bin" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# Ruby
if [ -d "$HOME/.rbenv/bin" ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

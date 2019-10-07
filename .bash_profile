if [ -n "$BASH_VERSION" ]; then
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

export PATH="$HOME/bin:$HOME/.local/bin:$PATH"

# Homebrew
if [ -d '/home/linuxbrew/.linuxbrew/bin' ]; then
  PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi
if [ -d "$HOME/.linuxbrew/bin" ]; then
  PATH="$HOME/.linuxbrew/bin:$PATH"
fi

# Rust
if [ -d "$HOME/.cargo/bin" ]; then
  PATH="$HOME/.cargo/bin:$PATH"
fi

# Ruby
if [ -d "$HOME/.rbenv/bin" ]; then
  PATH="$HOME/.rbenv/bin:$PATH"
fi
if type rbenv >/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

# Node
if [ -d "$HOME/.nodenv/bin" ]; then
  PATH="$HOME/.nodenv/bin:$PATH"
fi
if type nodenv >/dev/null 2>&1; then
  eval "$(nodenv init -)"
fi

# WSL
if type cmd.exe >/dev/null 2>&1; then
  # X server
  export DISPLAY=127.0.0.1:0.0
fi

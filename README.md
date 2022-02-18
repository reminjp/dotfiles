# dotfiles

My development environment.

## Requirements

Set bash as your login shell.

```sh
chsh -s "$(which bash)"
```

## Installation

Run [`install.sh`](./install.sh).

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/rdrgn/dotfiles/HEAD/install.sh)"
```

See also:

- [Homebrew](https://brew.sh/)
- [rcm](https://github.com/thoughtbot/rcm)

## Notes

### Recommended external tools

#### [asdf](https://asdf-vm.com/)

```sh
brew install asdf
```

Install [asdf plugins](https://asdf-vm.com/guide/getting-started.html). Example:

```sh
# Install a plugin.
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git

# Install a version.
asdf install nodejs latest

# Set a version.
asdf global nodejs latest
# or
asdf global nodejs system
```

#### [iTerm2](https://iterm2.com/) (macOS)

```sh
brew install iterm2
```

- Disable `Preferences -> General -> Window -> Native full screen windows`.
- Enable full screen in `Preferences -> Profiles -> {Profile Name} -> Window -> Settings for New Windows`.
  - `Style`: `Full Screen`
  - `Screen`: `Screen with Cursor`
  - `Space`: `All Spaces`
- Enable `Preferences -> Keys -> Hotkey -> Show/hide all windows with a system-wide hotkey`.
  - The default hotkey is `Option + Space`.

## License

TBD

&copy; remin

# dotfiles

My development environment.

## Usage

```sh
# Display available commands.
make

# Install.
make install
```

### After the Installation

#### [asdf Plugins](https://asdf-vm.com/guide/getting-started.html) (Linux, macOS)

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

## Development

See also [b4b4r07/dotfiles](https://github.com/b4b4r07/dotfiles) and [an instruction of it](https://qiita.com/b4b4r07/items/b70178e021bef12cd4a2) (Japanese).

## License

TBD

&copy; remin

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

### Recommended additional tools (optional)

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

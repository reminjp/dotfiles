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

### GUI preferences (macOS)

#### [iTerm2](https://iterm2.com/)

- Disable `Preferences -> General -> Window -> Native full screen windows`.
- Enable full screen in `Preferences -> Profiles -> {Profile Name} -> Window -> Settings for New Windows`.
  - `Style`: `Full Screen`
  - `Screen`: `Screen with Cursor`
  - `Space`: `All Spaces`
- Enable `Preferences -> Keys -> Hotkey -> Show/hide all windows with a system-wide hotkey`.
  - The default hotkey is `Option + Space`.

#### [Magnet](https://apps.apple.com/jp/app/magnet-マグネット/id441258766)

Install from App Store.

#### [Scroll Reverser](https://pilotmoon.com/scrollreverser/)

- [x] Reverse Vertical (縦方向を逆にする)
- [x] Reverse Horizontal (横方向を逆にする)
- [ ] Reverse Trackpad (トラックパッドを逆にする)
- [x] Reverse Mouse (マウスを逆にする)

## License

TBD

&copy; remin

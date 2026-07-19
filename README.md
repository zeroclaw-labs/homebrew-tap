# ZeroClaw Homebrew Compatibility Tap

ZeroClaw is moving to the formula in Homebrew Core. This compatibility tap remains available for existing users and currently installs both the `zeroclaw` runtime and the `zerocode` TUI.

Until the Core formula includes both binaries, install or upgrade from this tap:

```sh
brew install zeroclaw-labs/tap/zeroclaw
brew upgrade zeroclaw-labs/tap/zeroclaw
```

Verify the installed versions match:

```sh
zeroclaw --version
zerocode --version
```

## Migration

After the Homebrew Core formula installs both binaries, migrate with:

```sh
brew uninstall zeroclaw-labs/tap/zeroclaw
brew untap zeroclaw-labs/tap
brew install zeroclaw
```

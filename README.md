# ZeroClaw Homebrew Compatibility Tap

ZeroClaw is available from Homebrew Core, which installs both the `zeroclaw` runtime and the `zerocode` TUI. New installations should use:

```sh
brew install zeroclaw
```

This compatibility tap remains temporarily available for existing users but is deprecated and will not receive further version updates.

## Migration

Move an existing tap installation to Homebrew Core with:

```sh
brew uninstall zeroclaw-labs/tap/zeroclaw
brew untap zeroclaw-labs/tap
brew install zeroclaw
```

Verify the installed versions match:

```sh
zeroclaw --version
zerocode --version
```

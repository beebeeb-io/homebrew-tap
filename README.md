<p align="center">
  <a href="https://beebeeb.io"><img src="https://beebeeb.io/assets/beebeeb-icon.png" alt="beebeeb" width="72" height="72" /></a>
</p>
<h1 align="center">beebeeb homebrew tap</h1>
<p align="center">Homebrew formulae for beebeeb — <code>brew install beebeeb-io/tap/bb</code>.</p>
<p align="center"><strong>We can't recover your data. Not even if we wanted to.</strong> That's the point.</p>
<p align="center">
  <a href="https://get.beebeeb.io"><img src="https://img.shields.io/badge/install-bb-f5b800.svg" alt="Install" /></a> &nbsp;
  <img src="https://img.shields.io/badge/homebrew-tap-555.svg" alt="Homebrew tap" /> &nbsp;
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-555.svg" alt="License: MIT" /></a> &nbsp;
  <a href="SECURITY.md"><img src="https://img.shields.io/badge/security-policy-555.svg" alt="Security policy" /></a>
</p>
<p align="center"><a href="https://beebeeb.io">Website</a> &nbsp;·&nbsp; <a href="https://beebeeb.io/security">How it works</a> &nbsp;·&nbsp; <a href="SECURITY.md">Report a vulnerability</a></p>
<p align="center"><sub>End-to-end encrypted cloud storage, built in Europe. Operated by Initlabs B.V., Wijchen, Netherlands.</sub></p>

---

This is the official [Homebrew](https://brew.sh) tap for beebeeb. It ships the `bb` command-line client — encrypt, sync, and share from your terminal; the server never sees plaintext.

## Usage

```sh
brew tap beebeeb-io/tap
brew install bb
```

Or in a single step:

```sh
brew install beebeeb-io/tap/bb
```

Upgrade later with `brew upgrade bb`. The formula installs prebuilt binaries from the [cli release page](https://github.com/beebeeb-io/cli/releases/latest) for macOS (Apple Silicon and Intel) and Linux.

Full CLI reference lives in the [cli repo](https://github.com/beebeeb-io/cli) — or run `bb --help` after installing.

## Security

Found a vulnerability? Email **security@beebeeb.io** — see [SECURITY.md](SECURITY.md).

## Part of beebeeb

End-to-end encrypted, zero-knowledge cloud storage — made in Europe.
[core](https://github.com/beebeeb-io/core) · [cli](https://github.com/beebeeb-io/cli) · [web](https://github.com/beebeeb-io/web) · [mobile](https://github.com/beebeeb-io/mobile) · [desktop](https://github.com/beebeeb-io/desktop) · [website](https://beebeeb.io)

## License

[MIT](LICENSE) — © Initlabs B.V., Wijchen, Netherlands. The `bb` binary it installs is AGPL-3.0 (see the [cli repo](https://github.com/beebeeb-io/cli)).

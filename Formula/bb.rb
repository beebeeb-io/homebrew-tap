class Bb < Formula
  desc "bb — Beebeeb CLI for end-to-end encrypted cloud storage"
  homepage "https://beebeeb.io"
  version "0.13.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.13.2/beebeeb-cli-aarch64-apple-darwin.tar.xz"
      sha256 "3f3f2ffac9306ddb2b729f12cda385e7bb108cf8eae6c72dc72d49fef1795a6b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.13.2/beebeeb-cli-x86_64-apple-darwin.tar.xz"
      sha256 "c4cf7df903a78e820c7b8784595b7fed2b59fc6ea8696e9c72df1ceec25f669b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.13.2/beebeeb-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "82180fb29b6373e21615e691ecd002ad7909d59f3af87440e6300eaad0ecd323"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.13.2/beebeeb-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "2efc0ff966a89edad92f782e6af7a02d37d080ad70f7d21bdcccfd7fbee7d78e"
    end
  end
  license "AGPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "bb"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "bb"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "bb"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "bb"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

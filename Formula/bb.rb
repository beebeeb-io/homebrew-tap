class Bb < Formula
  desc "bb — Beebeeb CLI for end-to-end encrypted cloud storage"
  homepage "https://beebeeb.io"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.4.0/beebeeb-cli-aarch64-apple-darwin.tar.xz"
      sha256 "27c788a7af0c4fde47f93355b37f956ebd8d6ce9b8ac3f62c19402fca2c32d72"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.4.0/beebeeb-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f8082ba237592c28cb80666bcff293d60cf15167334d8d59677fff6bc36c212b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.4.0/beebeeb-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "6116fcb87f924ee3c41c95b740fcdd58856c7b3b299323b83354e4de1658693f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.4.0/beebeeb-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "aca19a68072ab8a392d2db7245565b5c294cb59a4f579e72a257b5d02ffb32b6"
    end
  end
  license "AGPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
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
    bin.install "bb" if OS.mac? && Hardware::CPU.arm?
    bin.install "bb" if OS.mac? && Hardware::CPU.intel?
    bin.install "bb" if OS.linux? && Hardware::CPU.arm?
    bin.install "bb" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

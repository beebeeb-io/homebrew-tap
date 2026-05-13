class Bb < Formula
  desc "bb — Beebeeb CLI for end-to-end encrypted cloud storage"
  homepage "https://beebeeb.io"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.2.1/beebeeb-cli-aarch64-apple-darwin.tar.xz"
      sha256 "1f3561007ca859e9c273e85183d2eae24ea6f1ee4a2e52003ff181ccbfb84a01"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.2.1/beebeeb-cli-x86_64-apple-darwin.tar.xz"
      sha256 "3882c25820494e73b14ebc52e377f61c2fddd1eed21efb16e7b61ceddc64dc4e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.2.1/beebeeb-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "63afb9bb30b488b84b68ba97c69e0a6465cb3f991f7930827c6ba84682f7e173"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.2.1/beebeeb-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "f9b634e16907b62fdec84aa691de2324cb2320a88858f032e279fa99767fa690"
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

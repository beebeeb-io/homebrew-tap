class Bb < Formula
  desc "bb — Beebeeb CLI for end-to-end encrypted cloud storage"
  homepage "https://beebeeb.io"
  version "0.12.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.12.0/beebeeb-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f215b205888361989c01cf011a373ec8062c7667d629cab42fee8916ec1d46d5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.12.0/beebeeb-cli-x86_64-apple-darwin.tar.xz"
      sha256 "5a94c05a319166f3ae0402b1171d2f1f915afe9ecaa02ad0c135ba270123c23f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.12.0/beebeeb-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "39afabab06e7f6afc8c490c55eca973e08768f14a34dd64506d9587e8b615160"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.12.0/beebeeb-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "fdc661f1f3836e93dbb5f6bba0aa216c6b899adda342dfa1a3896103fe5719a0"
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

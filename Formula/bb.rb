class Bb < Formula
  desc "bb — Beebeeb CLI for end-to-end encrypted cloud storage"
  homepage "https://beebeeb.io"
  version "0.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.11.0/beebeeb-cli-aarch64-apple-darwin.tar.xz"
      sha256 "e0ac97648287e89984b7154abad96b523e646cd46fa8057e7c925306be2496db"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.11.0/beebeeb-cli-x86_64-apple-darwin.tar.xz"
      sha256 "0028d33279266033ecaa762f9d4c3aeca7d2d5b0368506a5fb8c8d46f207846e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.11.0/beebeeb-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "92f7f2dface9f22b3ce8f4e9b7bdaa6ea6de89ccd0b4b94ee2dced02de5ae38d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.11.0/beebeeb-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "9dd35644cd16579f11ba94c7544683ffbed954469a5ea56a8cf553d6bd0a5d23"
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

class Bb < Formula
  desc "bb — Beebeeb CLI for end-to-end encrypted cloud storage"
  homepage "https://beebeeb.io"
  version "0.3.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.3.3/beebeeb-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d3fa800a23e5418254ab9fd23350cd1c964b005e9aac56aa5ab0434a1d874c69"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.3.3/beebeeb-cli-x86_64-apple-darwin.tar.xz"
      sha256 "05e56ee3048e00ab1ea3632ac0b2dcaf07a03c9ed845c93d52f58910cd3e56c1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.3.3/beebeeb-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "e0b540d1cf5be8ef0bb5ea2822bb65b6aa390d17f198c3016aaf4c976dd87041"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.3.3/beebeeb-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "da2037f4353e880ce33ffabb24ec4e18efaae65548029a8c8b3f94eb556a3d7d"
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

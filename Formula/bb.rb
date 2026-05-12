class Bb < Formula
  desc "bb — Beebeeb CLI for end-to-end encrypted cloud storage"
  homepage "https://beebeeb.io"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.1.3/beebeeb-cli-aarch64-apple-darwin.tar.xz"
      sha256 "14e63f9640b5fd4a3fb78a3dd62709f28f898bf2033c93969db3a20cdec0db64"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.1.3/beebeeb-cli-x86_64-apple-darwin.tar.xz"
      sha256 "63f12a20882040587dd473693c12f3a733d1063c17716964e5a51def553b361a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.1.3/beebeeb-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "c345b59a5a25d7396797c03443036a168925b6d94b50875291cf414327c5b51c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.1.3/beebeeb-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "d7847e7503b7e88cdf18998994003039f650ec04298f119e90d9239133ece7b0"
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

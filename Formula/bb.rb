class Bb < Formula
  desc "bb — Beebeeb CLI for end-to-end encrypted cloud storage"
  homepage "https://beebeeb.io"
  version "0.16.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.16.0/beebeeb-cli-aarch64-apple-darwin.tar.xz"
      sha256 "6cf9dc1668061b9cf25a27874766e286c9b2d496553694c8832c97496b7ffb92"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.16.0/beebeeb-cli-x86_64-apple-darwin.tar.xz"
      sha256 "9f237dbae4f35cdcd6d60785d953b023498446768d621fe4430c25e9e3c45401"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.16.0/beebeeb-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "5d9fc0e167ba1fd99b2e7cd3e8bfd180ddbe6925efb7e6c2acb6d7d341faf7d8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.16.0/beebeeb-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "5a36bc92a2bfb082fe49bd337b73671cf4dd1146deea3e8dd74eb781b190230c"
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

class Bb < Formula
  desc "bb — Beebeeb CLI for end-to-end encrypted cloud storage"
  homepage "https://beebeeb.io"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.9.0/beebeeb-cli-aarch64-apple-darwin.tar.xz"
      sha256 "764a382591f08cb5f1ec601c90b7a50c1facfad796374008345e19bf1c4ddf1b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.9.0/beebeeb-cli-x86_64-apple-darwin.tar.xz"
      sha256 "1e123859620c7bc703403fcb43c8e834ab593700d9837df20a9625bbf792d065"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.9.0/beebeeb-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "f66dde52f449e1f2c56a17ea4c8fd35ccb2774854228da707414479efad9dd65"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.9.0/beebeeb-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "f08a5fd64cceb6f1bbdaf82327b48cbaf24f2011fe1830832a81dc4673da95e5"
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

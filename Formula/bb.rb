class Bb < Formula
  desc "bb — Beebeeb CLI for end-to-end encrypted cloud storage"
  homepage "https://beebeeb.io"
  version "0.13.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.13.4/beebeeb-cli-aarch64-apple-darwin.tar.xz"
      sha256 "5f79e3231ff119523c485d364137e0ae66404f79b484b2d7ce6ade7be9d68117"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.13.4/beebeeb-cli-x86_64-apple-darwin.tar.xz"
      sha256 "d7ce9ac0ed0185305129d0ebe758aaa95da5aad60aaec1e49009d2fccb32f448"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.13.4/beebeeb-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "056783954ea4031c8536ee66d508cdc9f6b0160b0032acf8f72736d507fd41eb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/beebeeb-io/cli/releases/download/v0.13.4/beebeeb-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "d2c9c67546cf34a25bb034b49d40af90ba27d38de5420fc737bc27419e109162"
    end
  end
  license "AGPL-3.0-or-later"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

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

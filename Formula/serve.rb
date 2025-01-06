class Serve < Formula
  desc "serve a directory"
  homepage "https://gh.freemasen.com/serve"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/FreeMasen/serve/releases/download/v0.1.2/serve-aarch64-apple-darwin.tar.xz"
      sha256 "6603b892289823bd23421b9798bfe73272b8ac952f2bf2338272b8df75a3d13c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FreeMasen/serve/releases/download/v0.1.2/serve-x86_64-apple-darwin.tar.xz"
      sha256 "bf484b93e6cca97982fb9f508f91df120163db380c43444ea2dc20eb7f046a33"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/FreeMasen/serve/releases/download/v0.1.2/serve-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "33365f4e4741d94397e67f35ea95ba118f72926431adc8cba935f55bf24c26c0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FreeMasen/serve/releases/download/v0.1.2/serve-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bbe82feaa2a9f712eb190a70160673ed256b43c7444b9209019df093651f7860"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
    bin.install "serve" if OS.mac? && Hardware::CPU.arm?
    bin.install "serve" if OS.mac? && Hardware::CPU.intel?
    bin.install "serve" if OS.linux? && Hardware::CPU.arm?
    bin.install "serve" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

class ResumeTui < Formula
  desc "My resume as a TUI application"
  homepage "https://github.com/FreeMasen/resume-tui"
  version "0.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/FreeMasen/resume-tui/releases/download/v0.0.4/resume-tui-aarch64-apple-darwin.tar.xz"
      sha256 "08d51a17e4982fed7132e0a88e56795e8564fd9f028d8acc20cddf3e7d66736b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FreeMasen/resume-tui/releases/download/v0.0.4/resume-tui-x86_64-apple-darwin.tar.xz"
      sha256 "5ec212c3e092682cb8d769007cf1cb842a2b059a4831c87d9667fd2b5f2b915b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/FreeMasen/resume-tui/releases/download/v0.0.4/resume-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9c25c09437ee59acf7ab7707f3f31931e229305e50172c69f25068e3c30fff64"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FreeMasen/resume-tui/releases/download/v0.0.4/resume-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "561aa88e29e69cdd726228b98ac13fb8bdb407214a070d22b66bd53b37272e0d"
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
    bin.install "resume-tui" if OS.mac? && Hardware::CPU.arm?
    bin.install "resume-tui" if OS.mac? && Hardware::CPU.intel?
    bin.install "resume-tui" if OS.linux? && Hardware::CPU.arm?
    bin.install "resume-tui" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

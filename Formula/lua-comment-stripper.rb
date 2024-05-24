class LuaCommentStripper < Formula
  desc "A tool for stripping comments but preserving line numbers of lua script files"
  homepage "https://github.com/FreeMasen/lua-comment-stripper"
  version "0.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/FreeMasen/lua-comment-stripper/releases/download/v0.1.1/lua-comment-stripper-aarch64-apple-darwin.tar.xz"
      sha256 "8df66e9f24219a94e1dd7ad3abc670b3c4b0d157c9c45e2e00f7d9af65b4c2f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FreeMasen/lua-comment-stripper/releases/download/v0.1.1/lua-comment-stripper-x86_64-apple-darwin.tar.xz"
      sha256 "84a4caa814dc867b38476dd4192e457d7c9be1a30c583356da8c7fa9fa687310"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/FreeMasen/lua-comment-stripper/releases/download/v0.1.1/lua-comment-stripper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "836fbebed47663df331752451c2a122b05a291a5e6d598276c24ce1059492cdf"
    end
  end

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
      bin.install "lua-comment-stripper"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lua-comment-stripper"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lua-comment-stripper"
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

class LuaCommentStripper < Formula
  desc "A tool for stripping comments but preserving line numbers of lua script files"
  homepage "https://github.com/FreeMasen/lua-comment-stripper"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/FreeMasen/lua-comment-stripper/releases/download/v0.1.4/lua-comment-stripper-aarch64-apple-darwin.tar.xz"
      sha256 "45ae1a2b98c855a784229f192d89ac8a38e91ab7bbc183d5e7300e72c29ef717"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FreeMasen/lua-comment-stripper/releases/download/v0.1.4/lua-comment-stripper-x86_64-apple-darwin.tar.xz"
      sha256 "6d46349a2269d38874652c63184cb4fb30ad0011ec3c0b181915ecac788cb2d4"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/FreeMasen/lua-comment-stripper/releases/download/v0.1.4/lua-comment-stripper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a44182688f5c86116f1e9cdc45c059b7fa75ad28cbffd62eca8920162cd6e1bd"
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

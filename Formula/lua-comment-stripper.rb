class LuaCommentStripper < Formula
  desc "A tool for stripping comments but preserving line numbers of lua script files"
  homepage "https://github.com/FreeMasen/lua-comment-stripper"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/FreeMasen/lua-comment-stripper/releases/download/v0.1.3/lua-comment-stripper-aarch64-apple-darwin.tar.xz"
      sha256 "3b24cff2e72272fb262575b9a7c0c35379ea278a4bc5b93658d7d29ee27c3cc7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FreeMasen/lua-comment-stripper/releases/download/v0.1.3/lua-comment-stripper-x86_64-apple-darwin.tar.xz"
      sha256 "f7b63b72034150e88e57edc470ca80b81a509ca1eb2c429da0979fc99147dee8"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/FreeMasen/lua-comment-stripper/releases/download/v0.1.3/lua-comment-stripper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "19e2d39a0a790237a3f80a47ca9319dcb9bdddbdee9a0d77200632669b8b3ea3"
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

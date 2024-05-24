class LuaCommentStripper < Formula
  desc "A tool for stripping comments but preserving line numbers of lua script files"
  homepage "https://github.com/FreeMasen/lua-comment-stripper"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/FreeMasen/lua-comment-stripper/releases/download/v0.1.2/lua-comment-stripper-aarch64-apple-darwin.tar.xz"
      sha256 "3a229ad2f3c73ef9cfda58c15c616ce15a6c5fecc7e3da6e908c5095728b8350"
    end
    if Hardware::CPU.intel?
      url "https://github.com/FreeMasen/lua-comment-stripper/releases/download/v0.1.2/lua-comment-stripper-x86_64-apple-darwin.tar.xz"
      sha256 "6b4d134adb316a4270274b76231529741c2c63e684200f679a0395d53202c5ad"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/FreeMasen/lua-comment-stripper/releases/download/v0.1.2/lua-comment-stripper-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3e9d1abad73a49021d43f494b0c6f6deea867aec987bbb8f39849bb260e46c78"
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

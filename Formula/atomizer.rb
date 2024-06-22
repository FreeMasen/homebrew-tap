class Atomizer < Formula
  desc "A terminal Atom feed reader"
  homepage "https://gh.freemasen.com/atomizer"
  version "0.1.0"
  on_macos do
    on_arm do
      url "https://github.com/FreeMasen/atomizer/releases/download/v0.1.0/atomizer-aarch64-apple-darwin.tar.xz"
      sha256 "06370291ce88e884704d837f3759894483d7d298b6c0adf434b3233a554bf243"
    end
    on_intel do
      url "https://github.com/FreeMasen/atomizer/releases/download/v0.1.0/atomizer-x86_64-apple-darwin.tar.xz"
      sha256 "06e69cc876f05b7e95a8238a8c39e045a55b06fc07af41a5eac32f724d0b0f35"
    end
  end
  on_linux do
    on_intel do
      url "https://github.com/FreeMasen/atomizer/releases/download/v0.1.0/atomizer-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d83a121b9efeffe96137e5c688f066d581f6aa5bff8b6203c7930d416c1f45ee"
    end
  end
  license "MIT"

  def install
    on_macos do
      on_arm do
        bin.install "atomizer"
      end
    end
    on_macos do
      on_intel do
        bin.install "atomizer"
      end
    end
    on_linux do
      on_intel do
        bin.install "atomizer"
      end
    end

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install *leftover_contents unless leftover_contents.empty?
  end
end

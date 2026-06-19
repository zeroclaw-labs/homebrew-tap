class Zeroclaw < Formula
  desc "Rust-first autonomous agent runtime"
  homepage "https://github.com/zeroclaw-labs/zeroclaw"
  url "https://github.com/zeroclaw-labs/zeroclaw/archive/refs/tags/v0.8.1.tar.gz"
  version "0.8.1"
  sha256 "309cac6640481e7067f5cef041b83b13b8cdd7ca6747a5bf4a461a6b0ea5246b"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64

    on_arm do
      url "https://github.com/zeroclaw-labs/zeroclaw/releases/download/v0.8.1/zeroclaw-aarch64-apple-darwin.tar.gz"
      sha256 "d37c15aba3e4e6ec622d305b3d36172964a1239245704fb758e1d01560362841"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/zeroclaw-labs/zeroclaw/releases/download/v0.8.1/zeroclaw-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "0597dbd826195ebdc369e43878de5b40948a0cc16c0e36852f7e36cb0862a689"
    else
      url "https://github.com/zeroclaw-labs/zeroclaw/releases/download/v0.8.1/zeroclaw-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "149e0fa57c3ac2246994a7acca0d9e47a1f2fdfa59b1cbb7b0cb9abba0467086"
    end
  end

  def install
    libexec.install "zeroclaw"
    libexec.install "zerocode"
    libexec.install "web" if Dir.exist?("web")

    bin.install_symlink libexec/"zeroclaw"
    bin.install_symlink libexec/"zerocode"
  end

  service do
    run [opt_bin/"zeroclaw", "daemon"]
    keep_alive true
    working_dir var/"zeroclaw"
    environment_variables ZEROCLAW_WORKSPACE: var/"zeroclaw"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zeroclaw --version")
    assert_match version.to_s, shell_output("#{bin}/zerocode --version")
    assert_match "ZeroClaw", shell_output("#{bin}/zeroclaw --help")
  end
end

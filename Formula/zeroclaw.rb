class Zeroclaw < Formula
  desc "Rust-first autonomous agent runtime"
  homepage "https://github.com/zeroclaw-labs/zeroclaw"
  url "https://github.com/zeroclaw-labs/zeroclaw/archive/refs/tags/v0.8.3.tar.gz"
  version "0.8.3"
  sha256 "9dd537164012bd122cdc4837b09a20146ea3311aa493cd642a870778871f0d27"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/zeroclaw-labs/zeroclaw/releases/download/v0.8.3/zeroclaw-aarch64-apple-darwin.tar.gz"
      sha256 "13b4292d30d2e2eb5200d62ea12879fcbc691fff4102b36439a82d2a0093124a"
    end

    on_intel do
      url "https://github.com/zeroclaw-labs/zeroclaw/releases/download/v0.8.3/zeroclaw-x86_64-apple-darwin.tar.gz"
      sha256 "b85761b90429e101369b8f93b3558b8bc54b47c4fbb7052a4f1913dbebd1ab7d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/zeroclaw-labs/zeroclaw/releases/download/v0.8.3/zeroclaw-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d910d98821f13eaf7cd2037785fd95bb0a9e14700cb71cadea9c8d9328cf8e66"
    else
      url "https://github.com/zeroclaw-labs/zeroclaw/releases/download/v0.8.3/zeroclaw-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "662abfa20afc5790538e69aebc1be60e188d34ba64f96fd81505bbcdd8edce44"
    end
  end

  def install
    if File.exist?("Cargo.toml")
      system "cargo", "install", *std_cargo_args(path: ".")
      system "cargo", "install", *std_cargo_args(path: "apps/zerocode")
      return
    end

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

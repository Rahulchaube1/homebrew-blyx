class Blyx < Formula
  desc "Compiler and interpreter for the Blyx programming language"
  homepage "https://www.blyx-lang.space/"
  version "0.2.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyxxxx/releases/download/v0.2.3/blyx-v0.2.3-aarch64-apple-darwin.tar.gz"
    sha256 "50f96ca0752a780f172c2bbc4bd8f4cf61bd2810a6c985f1d51e6b0c22d4b30b"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyxxxx/releases/download/v0.2.3/blyx-v0.2.3-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "94f6f6b3ac8d048dee83d508f68e8d633e6c341eb8cc87d4eef30bcfd85eadab"
  end

  def install
    bin.install "blyxc"
  end

  test do
    assert_equal "blyxc #{version}", shell_output("#{bin}/blyxc --version").strip
    (testpath/"hello.blyx").write "fn main() { println!(6 * 7); }"
    assert_equal "42", shell_output("#{bin}/blyxc run hello.blyx").strip
  end
end

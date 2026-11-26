class Blyx < Formula
  desc "Compiler and interpreter for the Blyx programming language"
  homepage "https://www.blyx-lang.space/"
  version "0.2.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyxxxx/releases/download/v0.2.2/blyx-v0.2.2-aarch64-apple-darwin.tar.gz"
    sha256 "6ff485ed07ef053b6466909fd5db089bfcafdaab8acb5dec3e7ae9a9b9f56f3c"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyxxxx/releases/download/v0.2.2/blyx-v0.2.2-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "bcbd5fe88a9f8bee4151f00e451e2a5e1047ea9f22b37337861bf0cf1774c482"
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

class Blyx < Formula
  desc "Compiler and interpreter for the Blyx programming language"
  homepage "https://www.blyx-lang.space/"
  version "0.2.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyxxxx/releases/download/v0.2.1/blyx-v0.2.1-aarch64-apple-darwin.tar.gz"
    sha256 "0778e0cd7a2d7941e6c90ec346530c57df25325b8513729ee0e0c24c317b8e34"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyxxxx/releases/download/v0.2.1/blyx-v0.2.1-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "792d5310bed715b2f6a2b7249606428f9ab2e8a57bdbd9abaff85d8aca2c1bdc"
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

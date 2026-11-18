class Blyx < Formula
  desc "Compiler and interpreter for the Blyx programming language"
  homepage "https://www.blyx-lang.space/"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyxxxx/releases/download/v0.2.0/blyx-v0.2.0-aarch64-apple-darwin.tar.gz"
    sha256 "801c74f8df62d1ecb7eb8c57e1fa90550f2d18420c66b26b1b0d8c7121004d28"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyxxxx/releases/download/v0.2.0/blyx-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
    sha256 "74a81c9053c866fb729f17646b6f0f6dc6b0b78f684037073e7160160e62bfda"
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

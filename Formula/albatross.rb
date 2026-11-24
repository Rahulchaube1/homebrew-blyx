class Albatross < Formula
  desc "Plan build capacity and sharded model training memory"
  homepage "https://github.com/Rahulchaube1/blyx-albatross"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyx-albatross/releases/download/v0.2.0/albatross-macos-arm64.tar.gz"
    sha256 "79ec83ffb982051fd0b8dd9d95792bd6cfff59cf926511fbe43241eee318bfc7"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyx-albatross/releases/download/v0.2.0/albatross-linux-x64.tar.gz"
    sha256 "861cb5af64955d0f35322e1e6c304bccaaa6b585c413a5ccaf56e6e9ea488106"
  end

  def install
    bin.install "albatross"
    pkgshare.install Dir["*.blyx"], "Blyx.toml", "SCALE.md"
  end

  test do
    assert_equal "albatross #{version}", shell_output("#{bin}/albatross --version").strip
    assert_equal "68719476736", shell_output("#{bin}/albatross state 2199023255552 512 0 3 2 2 12").strip
  end
end

class Chaffinch < Formula
  desc "Merge count streams and sparse gradient sums"
  homepage "https://github.com/Rahulchaube1/blyx-chaffinch"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyx-chaffinch/releases/download/v0.2.0/chaffinch-macos-arm64.tar.gz"
    sha256 "1903eb47805575be7f0161161621af8237795a1d38939896238590272aacc4b8"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyx-chaffinch/releases/download/v0.2.0/chaffinch-linux-x64.tar.gz"
    sha256 "486b15536b40d048cafb9103f16e37372021e24e9ebf00ad7e3786a49d2a48d7"
  end

  def install
    bin.install "chaffinch"
    pkgshare.install Dir["*.blyx"], "Blyx.toml", "SCALE.md"
    pkgshare.install "fixtures"
  end

  test do
    assert_equal "chaffinch #{version}", shell_output("#{bin}/chaffinch --version").strip
    assert_match "7,0.25", shell_output("#{bin}/chaffinch reduce 4 #{pkgshare}/fixtures/worker-a.csv #{pkgshare}/fixtures/worker-b.csv")
  end
end

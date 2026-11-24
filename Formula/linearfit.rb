class Linearfit < Formula
  desc "Fit linear, ridge and factored bilinear regressions in Blyx"
  homepage "https://github.com/Rahulchaube1/blyx-linearfit"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyx-linearfit/releases/download/v0.2.0/linearfit-macos-arm64.tar.gz"
    sha256 "9edf6379f0d270b1f70bbfa86dabec484548ca4e99c77a0092fe1f8e9947bb97"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyx-linearfit/releases/download/v0.2.0/linearfit-linux-x64.tar.gz"
    sha256 "9da01200563652930f5a8265a50090e03274539aeeb981ec45e7a74169928ac7"
  end

  def install
    bin.install "linearfit"
    bin.install "pair-study"
    pkgshare.install "bilinear.blyx", "scale_example.blyx", "SCALE.md"
    pkgshare.install "fixtures"
  end

  test do
    assert_match '"updates":48', shell_output("#{bin}/pair-study dense 4")
    assert_equal "linearfit #{version}", shell_output("#{bin}/linearfit --version").strip
    assert_match '"prediction":11', shell_output("#{bin}/linearfit #{pkgshare}/fixtures/line.csv --predict 5")
  end
end

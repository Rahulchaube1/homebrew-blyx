class Linearfit < Formula
  desc "Fit a one-feature linear or ridge regression from a CSV"
  homepage "https://github.com/Rahulchaube1/blyx-linearfit"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyx-linearfit/releases/download/v0.1.0/linearfit-macos-arm64.tar.gz"
    sha256 "4034659e08502952d60bcd0c547f1f0f24bc2459ea3e0d66b3610557c3194270"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyx-linearfit/releases/download/v0.1.0/linearfit-linux-x64.tar.gz"
    sha256 "ebe420e131075e2b297b2d29e04eaddf8d9c28f0126eb29541d31bc4c2086d71"
  end

  def install
    bin.install "linearfit"
    pkgshare.install "fixtures"
  end

  test do
    assert_equal "linearfit #{version}", shell_output("#{bin}/linearfit --version").strip
    assert_match '"prediction":11', shell_output("#{bin}/linearfit #{pkgshare}/fixtures/line.csv --predict 5")
  end
end

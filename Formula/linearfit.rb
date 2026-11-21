class Linearfit < Formula
  desc "Fit a one-feature linear or ridge regression from a CSV"
  homepage "https://github.com/Rahulchaube1/blyx-linearfit"
  version "0.1.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyx-linearfit/releases/download/v0.1.1/linearfit-macos-arm64.tar.gz"
    sha256 "4f47131ce651440b1805d866f41361a5755fa5ee93f078bfedae7cb219cf42a7"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyx-linearfit/releases/download/v0.1.1/linearfit-linux-x64.tar.gz"
    sha256 "26e9df5c69b097da1e36b17fa12bcc917302c040b324f86f1aa296bbe3196e3f"
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

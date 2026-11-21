require "json"

class Blyxtorch < Formula
  desc "Train fixed-shape dense networks and emit standalone Blyx models"
  homepage "https://github.com/Rahulchaube1/blyxtorch"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyxtorch/releases/download/v0.1.0/blyxtorch-macos-arm64.tar.gz"
    sha256 "096529bc2c651002d5e903c8ee18cc703e72ed31936371bcecbd1f880bbd9939"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyxtorch/releases/download/v0.1.0/blyxtorch-linux-x64.tar.gz"
    sha256 "547253de83f3550cae420197366be7fc1b25c986dfefa61c6627658dc789481e"
  end

  def install
    libexec.install "blyxtorch", "blyxtorch.blyx", "training.blyx"
    bin.write_exec_script libexec/"blyxtorch"
    pkgshare.install "fixtures"
  end

  test do
    assert_equal "BlyxTorch #{version}", shell_output("#{bin}/blyxtorch --version").strip
    assert_match "pub fn bt_predict", shell_output("#{bin}/blyxtorch emit 2,3 softmax relu")
    (testpath/"xor.bt").write shell_output("#{bin}/blyxtorch train #{pkgshare}/fixtures/xor.csv 250 0.03 4 adam 7")
    result = JSON.parse(shell_output("#{bin}/blyxtorch score xor.bt #{pkgshare}/fixtures/xor.csv"))
    assert_equal 4, result.fetch("rows")
    assert_operator result.fetch("mean_loss"), :<, 0.01
  end
end

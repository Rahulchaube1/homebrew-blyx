require "json"

class Blyxtorch < Formula
  desc "Train fixed-shape dense networks and emit standalone Blyx models"
  homepage "https://github.com/Rahulchaube1/blyxtorch"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyxtorch/releases/download/v0.2.0/blyxtorch-macos-arm64.tar.gz"
    sha256 "a102f5f5279721d976bd24c7c60dd68739d1f7ea3323628eceddc22b03acbb35"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyxtorch/releases/download/v0.2.0/blyxtorch-linux-x64.tar.gz"
    sha256 "470caa87ee3d1cc90fad795a640cd3f4036260eaa3eb6e736aa29654014d57b0"
  end

  def install
    libexec.install "blyxtorch", "blyxtorch.blyx", "training.blyx"
    bin.write_exec_script libexec/"blyxtorch"
    pkgshare.install "fixtures", "assets", "projects"
  end

  test do
    assert_path_exists pkgshare/"assets/logo.png"
    data = pkgshare/"projects/print-queue"
    heldout = JSON.parse(shell_output("#{bin}/blyxtorch train-score #{data}/train.csv #{data}/holdout.csv 180 0.03 4 adam 7"))
    assert_equal 6, heldout.fetch("rows")
    assert_operator heldout.fetch("mean_loss"), :<, 0.01
    assert_equal "BlyxTorch #{version}", shell_output("#{bin}/blyxtorch --version").strip
    assert_match "pub fn bt_predict", shell_output("#{bin}/blyxtorch emit 2,3 softmax relu")
    (testpath/"xor.bt").write shell_output("#{bin}/blyxtorch train #{pkgshare}/fixtures/xor.csv 250 0.03 4 adam 7")
    result = JSON.parse(shell_output("#{bin}/blyxtorch score xor.bt #{pkgshare}/fixtures/xor.csv"))
    assert_equal 4, result.fetch("rows")
    assert_operator result.fetch("mean_loss"), :<, 0.01
  end
end

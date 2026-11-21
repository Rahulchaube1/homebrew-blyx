require "json"

class Blyxtorch < Formula
  desc "Train fixed-shape dense networks and emit standalone Blyx models"
  homepage "https://github.com/Rahulchaube1/blyxtorch"
  version "0.1.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyxtorch/releases/download/v0.1.1/blyxtorch-macos-arm64.tar.gz"
    sha256 "4a2b2fcde8249322f066cad969a96835c2c780e30069d81473742e0b9d751c4b"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyxtorch/releases/download/v0.1.1/blyxtorch-linux-x64.tar.gz"
    sha256 "5411a0224d7eb97ca03b9f068f891448e9a53465b148ba06ae9aa6312b6a4012"
  end

  def install
    libexec.install "blyxtorch", "blyxtorch.blyx", "training.blyx"
    bin.write_exec_script libexec/"blyxtorch"
    pkgshare.install "fixtures", "assets"
  end

  test do
    assert_path_exists pkgshare/"assets/logo.png"
    assert_equal "BlyxTorch #{version}", shell_output("#{bin}/blyxtorch --version").strip
    assert_match "pub fn bt_predict", shell_output("#{bin}/blyxtorch emit 2,3 softmax relu")
    (testpath/"xor.bt").write shell_output("#{bin}/blyxtorch train #{pkgshare}/fixtures/xor.csv 250 0.03 4 adam 7")
    result = JSON.parse(shell_output("#{bin}/blyxtorch score xor.bt #{pkgshare}/fixtures/xor.csv"))
    assert_equal 4, result.fetch("rows")
    assert_operator result.fetch("mean_loss"), :<, 0.01
  end
end

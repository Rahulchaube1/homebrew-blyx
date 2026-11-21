class Residualwatch < Formula
  desc "Detect sustained changes in prediction errors against a reference period"
  homepage "https://github.com/Rahulchaube1/blyx-residualwatch"
  version "0.1.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyx-residualwatch/releases/download/v0.1.0/residualwatch-macos-arm64.tar.gz"
    sha256 "aa3ad59278481e0c735717cbcad8011c4b5e3632c570ce979927b4c9d78b3907"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyx-residualwatch/releases/download/v0.1.0/residualwatch-linux-x64.tar.gz"
    sha256 "2e528dc645fdc648c2dd90f5e0b18f50a95fd9209e0056a6648cbb96cc91ae00"
  end

  def install
    bin.install "residualwatch"
    pkgshare.install "fixtures"
  end

  test do
    assert_equal "residualwatch #{version}", shell_output("#{bin}/residualwatch --version").strip
    assert_match '"alert":false', shell_output("#{bin}/residualwatch #{pkgshare}/fixtures/steady.csv --reference 3")
    assert_match '"first_alert_row":5', shell_output("#{bin}/residualwatch #{pkgshare}/fixtures/shift.csv --reference 3 --limit 3", 1)
  end
end

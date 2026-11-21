class Modelgate < Formula
  desc "Compare paired classifier predictions and fail CI on a regression"
  homepage "https://github.com/Rahulchaube1/blyx-modelgate"
  version "0.1.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyx-modelgate/releases/download/v0.1.2/modelgate-macos-arm64.tar.gz"
    sha256 "5b68a1057c98b3df957a3f4f21d30a1e6d170a65c3cdfdcbe9a465973d044900"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyx-modelgate/releases/download/v0.1.2/modelgate-linux-x64.tar.gz"
    sha256 "361beae41700021e00ec6f64a817898220872e97c82bb4aa19cde9b1886aa875"
  end

  def install
    bin.install "modelgate"
    pkgshare.install "fixtures"
  end

  test do
    assert_match '"pass":true', shell_output("#{bin}/modelgate #{pkgshare}/fixtures/improved.csv")
    assert_match '"pass":false', shell_output("#{bin}/modelgate #{pkgshare}/fixtures/regression.csv --fn-cost 5", 1)
  end
end

class Modelgate < Formula
  desc "Compare paired classifier predictions and fail CI on a regression"
  homepage "https://github.com/Rahulchaube1/blyx-modelgate"
  version "0.1.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyx-modelgate/releases/download/v0.1.1/modelgate-macos-arm64.tar.gz"
    sha256 "2029bb61cadcb57c8e53008771267e0c52b2bf030fcad20ed19b80fc3502169f"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyx-modelgate/releases/download/v0.1.1/modelgate-linux-x64.tar.gz"
    sha256 "cf8b2ce483338535876f145918403b20ebbaacb24ca14cfd49475ce83aeb266d"
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

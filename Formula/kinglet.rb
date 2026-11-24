class Kinglet < Formula
  desc "Plan HTTP ranges and tensor checkpoint slices"
  homepage "https://github.com/Rahulchaube1/blyx-kinglet"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyx-kinglet/releases/download/v0.2.0/kinglet-macos-arm64.tar.gz"
    sha256 "80a85d0e212cb65d5739e14cba939d45debe81bce284287d035eac9a283f07b7"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyx-kinglet/releases/download/v0.2.0/kinglet-linux-x64.tar.gz"
    sha256 "3abcc7b8a7a075089970cd6ac5941db622dd8d164d24c2725e31106fd91e09be"
  end

  def install
    bin.install "kinglet"
    pkgshare.install Dir["*.blyx"], "Blyx.toml", "SCALE.md"
  end

  test do
    assert_equal "kinglet #{version}", shell_output("#{bin}/kinglet --version").strip
    assert_match '"length":6', shell_output("#{bin}/kinglet range 2199023255552 2 1073741824 1099511627774 5 1")
  end
end

require "json"

class BlyxPackages < Formula
  desc "Blyx framework and library source collection with runnable examples"
  homepage "https://www.blyx-lang.space/packages"
  url "https://github.com/Rahulchaube1/blyx-packages/releases/download/v2026.11.24/blyx-packages-2026.11.24.zip"
  version "2026.11.24"
  sha256 "8fafada7dfbddafec039c49ea574997e7bc244c45e506f2fa26e0c7e832e6e45"
  license any_of: ["MIT", "Apache-2.0"]

  def install
    (share/"blyx").install Dir["share/blyx/*"]
    (share/"blyx").install "catalog.json"
  end

  test do
    catalog = JSON.parse((share/"blyx/catalog.json").read)
    assert_equal version.to_s, catalog.fetch("version")
    assert_equal 172, catalog.fetch("packages").size
    catalog.fetch("packages").each do |package|
      project = prefix/package.fetch("directory")
      assert_path_exists project/"main.blyx"
      assert_path_exists project/"vendor"/package.fetch("slug")/package.fetch("module")
    end
  end
end

require "json"

class BlyxPackages < Formula
  desc "Blyx framework and library source collection with runnable examples"
  homepage "https://www.blyx-lang.space/packages"
  url "https://github.com/Rahulchaube1/blyx-packages/releases/download/v2026.11.22/blyx-packages-2026.11.22.zip"
  version "2026.11.22"
  sha256 "d5a24a51a5ad3882afb81c40db68c360c2828d6d904a7745085c6898ee084057"
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

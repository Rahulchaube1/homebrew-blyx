require "json"

class Blyxtorch < Formula
  desc "Train neural networks in Blyx on CPU or Vulkan GPU"
  homepage "https://github.com/Rahulchaube1/blyxtorch"
  version "0.4.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyxtorch/releases/download/v0.4.0/blyxtorch-macos-arm64.tar.gz"
    sha256 "ecfc3b02d2da5d3b4903a103a1b962cf8724c793c6f6234f86ce18ec0bb63221"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyxtorch/releases/download/v0.4.0/blyxtorch-linux-x64.tar.gz"
    sha256 "dcf27f3c5cc053855bf3453c4372752330f9d694b04fb1ce308d33524c154cc4"
  end

  def install
    libexec.install "blyxtorch", "blyxtorch.blyx", "training.blyx", "device_fit.py"
    bin.write_exec_script libexec/"blyxtorch"
    pkgshare.install "fixtures", "assets", "projects"
    pkgshare.install "tensor_ops.blyx", "convolution.blyx", "attention.blyx", "transformer.blyx",
                     "embedding.blyx", "sequence_example.blyx", "LAYERS.md", "PORTABLE.md", "provider-tools.mjs"
    pkgshare.install "probe.blyx", "probe_cli.blyx", "probe_graph.blyx", "layer_graph.blyx", "numeric_io.blyx"
    pkgshare.install_symlink libexec/"blyxtorch.blyx"
  end

  test do
    assert_path_exists pkgshare/"assets/logo.png"
    assert_path_exists libexec/"device_fit.py"
    assert_match "stablehlo.dot_general", shell_output("#{bin}/blyxtorch probe-graph train 2 3 2")
    assert_match "transformer loss", shell_output("#{bin}/blyxtorch layer-demo")
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

require "json"

class Blyxtorch < Formula
  desc "Train CPU convolutions, transformers and sparse embeddings in Blyx"
  homepage "https://github.com/Rahulchaube1/blyxtorch"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyxtorch/releases/download/v0.3.0/blyxtorch-macos-arm64.tar.gz"
    sha256 "3c54ee332fafe5ad7dec71d388f9909625e0f26cb1d85f0dc2aa43c1b4ca4f71"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyxtorch/releases/download/v0.3.0/blyxtorch-linux-x64.tar.gz"
    sha256 "6d512dae13a3abccecc68796c463798315a402ea917a1c3fb5becdf95d021aea"
  end

  def install
    libexec.install "blyxtorch", "blyxtorch.blyx", "training.blyx"
    bin.write_exec_script libexec/"blyxtorch"
    pkgshare.install "fixtures", "assets", "projects"
    pkgshare.install "tensor_ops.blyx", "convolution.blyx", "attention.blyx", "transformer.blyx",
                     "embedding.blyx", "sequence_example.blyx", "LAYERS.md"
    pkgshare.install_symlink libexec/"blyxtorch.blyx"
  end

  test do
    assert_path_exists pkgshare/"assets/logo.png"
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

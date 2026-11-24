require "json"

class Blyxtorch < Formula
  desc "Train neural networks and differentiate quantum circuits in Blyx"
  homepage "https://github.com/Rahulchaube1/blyxtorch"
  version "0.5.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    depends_on arch: :arm64
    url "https://github.com/Rahulchaube1/blyxtorch/releases/download/v0.5.0/blyxtorch-macos-arm64.tar.gz"
    sha256 "80b962f635d6a1f1e5c905307161c096d674910cc4e91c031b848a389c22ba7d"
  end

  on_linux do
    depends_on arch: :x86_64
    url "https://github.com/Rahulchaube1/blyxtorch/releases/download/v0.5.0/blyxtorch-linux-x64.tar.gz"
    sha256 "93d22831b4b9ea94b0286c3c5cb910e0660822f665e1a9f1a7d08b42088653c2"
  end

  def install
    bin.install "quantum-study"
    pkgshare.install "quantum.blyx", "quantum_cli.blyx", "quantum_study.blyx", "scale_example.blyx", "SCALE.md"
    libexec.install "blyxtorch", "blyxtorch.blyx", "training.blyx", "device_fit.py"
    bin.write_exec_script libexec/"blyxtorch"
    pkgshare.install "fixtures", "assets", "projects"
    pkgshare.install "tensor_ops.blyx", "convolution.blyx", "attention.blyx", "transformer.blyx",
                     "embedding.blyx", "sequence_example.blyx", "LAYERS.md", "PORTABLE.md", "provider-tools.mjs"
    pkgshare.install "probe.blyx", "probe_cli.blyx", "probe_graph.blyx", "layer_graph.blyx", "numeric_io.blyx"
    pkgshare.install_symlink libexec/"blyxtorch.blyx"
  end

  test do
    assert_match "OPENQASM 3.0", shell_output("#{bin}/blyxtorch q-qasm 2 1 0.3,-0.7")
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

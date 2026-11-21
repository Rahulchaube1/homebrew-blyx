# Homebrew tap for Blyx

Install the Blyx command-line compiler on Apple Silicon macOS or x86-64 Linux.

```sh
brew install rahulchaube1/blyx/blyx
blyxc --version
brew test rahulchaube1/blyx/blyx
```

The formula installs the official release binary and verifies its SHA-256 checksum. Use `blyxc run` to interpret a program. To compile a native executable with `blyxc build`, install Rust and a host linker.

## Evaluate a model

ModelGate compares two sets of predictions for the same labelled observations. It reads a CSV with columns `label,baseline,candidate`, writes a JSON report and exits with status 1 if the candidate regresses.

```sh
brew install rahulchaube1/blyx/modelgate
modelgate predictions.csv --fn-cost 5
brew test rahulchaube1/blyx/modelgate
```

[ModelGate input and examples](https://github.com/Rahulchaube1/blyx-modelgate) · [Language guide](https://doc.blyx-lang.space/) · [Playground](https://www.blyx-lang.space/play) · [Compiler releases](https://github.com/Rahulchaube1/blyxxxx/releases)

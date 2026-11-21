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

## Train and monitor regression models

Install the native tools on Apple Silicon macOS or x86-64 Linux.

```sh
brew install rahulchaube1/blyx/linearfit rahulchaube1/blyx/residualwatch
linearfit train.csv --predict 5
residualwatch errors.csv --reference 100 --limit 5
```

LinearFit reads a CSV headed `x,y`. ResidualWatch reads time-ordered rows headed `actual,predicted`. Both emit JSON. An alert from ResidualWatch returns exit status 1. [LinearFit documentation](https://www.blyx-lang.space/packages/linearfit) · [ResidualWatch documentation](https://www.blyx-lang.space/packages/residualwatch)

## Train a dense network

Install the CPU trainer and Blyx model generator on Apple Silicon macOS or x86-64 Linux.

```sh
brew install rahulchaube1/blyx/blyxtorch
blyxtorch --version
blyxtorch emit 2,8,3 softmax relu > classifier.blyx
```

The default network trains directly on two-feature binary data. [BlyxTorch training guide](https://doc.blyx-lang.space/guide/blyxtorch)

## Install the framework and library sources

The collection includes 65 frameworks and 107 libraries. Each project has a runnable example, its expected output, and a vendor directory you can copy into your own program. Install Rust and a host linker to compile the examples with Blyx.

```sh
brew install rahulchaube1/blyx/blyx-packages
blyxc native-run "$(brew --prefix rahulchaube1/blyx/blyx-packages)/share/blyx/moments/main.blyx"
```

Moments prints 3, 12 and 2 on separate lines. [Individual packages in Conda](https://rahulchaube1.github.io/blyx-packages/) · [Release files and checksums](https://github.com/Rahulchaube1/blyx-packages/releases)

## Connect with Rahul Chaube

[Portfolio](https://www.rahulchaube1.com/) · [GitHub](https://github.com/Rahulchaube1) · [LinkedIn](https://www.linkedin.com/in/rahulchaube1) · [Hugging Face](https://huggingface.co/oncody) · [X](https://x.com/RahulChaube_) · [EverestQ](https://www.everestqai.com/) · [Contact](https://www.rahulchaube1.com/contact)

[Blyx website](https://www.blyx-lang.space/) · [BlyxTorch](https://www.blyx-lang.space/packages/blyxtorch) · [Handbook](https://doc.blyx-lang.space/) · [Community](https://www.blyx-lang.space/community)

Support Rahul’s open-source work through [GitHub Sponsors](https://github.com/sponsors/Rahulchaube1) or [Buy Me a Coffee](https://buymeacoffee.com/rahulchaube).

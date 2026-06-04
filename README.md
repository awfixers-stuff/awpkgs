# awpkgs

`awpkgs` is a collection of custom Nix packages that are not included in the official `nixpkgs` repository. These packages are frequently iterated on and often track proprietary, beta, or alpha software that may not be suitable for upstream inclusion.

## License

The **source code of this repository** (i.e., the Nix expressions, flakes, build scripts, and configuration files) is licensed under the **AWFixer Source Available License v0.4**. Please refer to the [`LICENSE.md`](LICENSE.md) file for the full terms and conditions.

### Important Notice Regarding Built Packages

The AWFixer Source Available License v0.4 applies **strictly to the source code of this repository itself**.

**It does not apply to the software packages built or fetched by this repository.** The applications, binaries, and upstream source code downloaded, built, or wrapped by the Nix expressions in `awpkgs` remain subject to their own original licenses as determined by their respective developers and copyright holders. 

You are responsible for ensuring that your use, distribution, and installation of the built packages comply with their respective upstream licenses, particularly when utilizing the proprietary or restricted software packaged here.
# awpkgs

`awpkgs` is a collection of custom Nix packages that are not included in the official `nixpkgs` repository. These packages are frequently iterated on and often track proprietary, beta, or alpha software that may not be suitable for upstream inclusion.

## CI

On push/PR to `main` or `master`, GitHub Actions runs [`ci/build-packages.sh`](ci/build-packages.sh) and builds every package in the flake. **The workflow fails only if a `nix build` fails.** Uploading workflow artifacts (and optional release assets on tags) uses `continue-on-error`, so upload problems do not fail an otherwise green build. See [`ci/README.md`](ci/README.md).

## License

The **source code of this repository** (i.e., the Nix expressions, flakes, build scripts, and configuration files) is licensed under the **AWFixer Source Available License v0.4**. Please refer to the [`LICENSE.md`](LICENSE.md) file for the full terms and conditions.

### Important Notice Regarding Built Packages

The AWFixer Source Available License v0.4 applies **strictly to the source code of this repository itself**.

**It does not apply to the software packages built or fetched by this repository.** The applications, binaries, and upstream source code downloaded, built, or wrapped by the Nix expressions in `awpkgs` remain subject to their own original licenses as determined by their respective developers and copyright holders. 

You are responsible for ensuring that your use, distribution, and installation of the built packages comply with their respective upstream licenses, particularly when utilizing the proprietary or restricted software packaged here.
## Notice Regarding Third-Party Repositories (nyx, NUR)
We include inputs for `chaotic-cx/nyx` and `nix-community/NUR` alongside `nixpkgs/unstable` in order to expand the availability of packages. However, we will **NOT** build or re-export packages directly from those repositories in our flake unless a well-articulated reason is presented. We choose to use them only as inputs to leverage available derivations for the things we do choose to build.
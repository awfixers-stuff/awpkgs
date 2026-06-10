{
  description = "awpkgs - custom Nix packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    bun-source = {
      url = "https://github.com/oven-sh/bun/releases/latest/download/bun-linux-x64.zip";
      flake = false;
    };
    zed-staging-source = {
      url = "github:zed-industries/zed";
    };
    zen-browser-source = {
      url = "https://github.com/zen-browser/desktop/releases/latest/download/zen.linux-x86_64.tar.xz";
      flake = false;
    };
    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    };
    nur = {
      url = "github:nix-community/NUR";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      bun-source,
      zed-staging-source,
      zen-browser-source,
      chaotic,
      nur,
    }:
    {
      packages.x86_64-linux =
        let
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        in
        {
          cursor = pkgs.callPackage ./packages/ides/cursor/default.nix { };
          helium = pkgs.callPackage ./packages/browsers/helium/default.nix { };
          antigravity = pkgs.callPackage ./packages/ides/antigravity/default.nix { };
          bun-latest = pkgs.callPackage ./packages/tooling/bun-latest/default.nix { inherit bun-source; };
          readest = pkgs.callPackage ./packages/entertainment/readest/default.nix { };
          zed-staging = zed-staging-source.packages.x86_64-linux.default;
          zen-browser = pkgs.callPackage ./packages/browsers/zen-browser/default.nix {
            inherit zen-browser-source;
          };
          default = self.packages.x86_64-linux.helium;
        };

      devShells.x86_64-linux.default =
        let
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        in
        pkgs.mkShell {
          packages = with pkgs; [
            just
            nixfmt
          ];
        };

      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt;
    };
}

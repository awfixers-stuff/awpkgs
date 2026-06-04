{
  description = "awpkgs - custom Nix packages";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    {
      packages.x86_64-linux =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
        in
        {
          cursor = pkgs.callPackage ./cursor/default.nix { };
          helium = pkgs.callPackage ./helium/default.nix { };
          antigravity = pkgs.callPackage ./antigravity/default.nix { };
          default = self.packages.x86_64-linux.helium;
        };

      devShells.x86_64-linux.default =
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
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

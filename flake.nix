{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: {

    packages.x86_64-linux = let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in {
      hello = pkgs.hello;
      cursor = pkgs.callPackage ./cursor {};
      default = self.packages.x86_64-linux.cursor;
    };

  };
}

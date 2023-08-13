{
  description = "Hyprshot flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system} = {
      hyprshot = pkgs.callPackage ./default.nix { };
      default = self.packages.${system}.hyprshot;
    };
  };
}

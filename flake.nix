{
  description = "Hyprshot flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprshot = rec {
      url = "github:Gustash/Hyprshot";
      flake = false;
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    packages.${system} = {
      hyprshot = pkgs.callPackage ./default.nix { src = inputs.hyprshot; };
      default = self.packages.${system}.hyprshot;
    };
  };
}

{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "hyprshot";
  version = "1.2.2";

  src = pkgs.fetchFromGitHub {
    owner = "Gustash";
    repo = "Hyprshot";
    rev = "${version}";
    sha256 = "sha256-f4fMIS3B01F090Cs3R846HwQsmFvdzx8w3ubPi06S5o=";
  };

  nativeBuildInputs = with pkgs; [
    makeWrapper
  ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src/hyprshot $out/bin
  '';

  postFixup = ''
    wrapProgram $out/bin/hyprshot \
      --suffix-each PATH : ${pkgs.lib.makeBinPath (with pkgs; [
        jq
        grim
        slurp
        wl-clipboard
        libnotify
        imagemagick
      ])}
  '';
}

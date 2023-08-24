{ pkgs ? import <nixpkgs> {}, src }:

pkgs.stdenv.mkDerivation {
  inherit src;

  name = "hyprshot";

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

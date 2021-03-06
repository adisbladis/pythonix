{
  pkgs ? (import <nixpkgs> {}).pkgs
}:

with pkgs;

let
  filterMesonBuild = dir: builtins.filterSource
    (path: type: type != "directory" || baseNameOf path != "build") dir;

in stdenv.mkDerivation {
  name = "pythonix";

  nativeBuildInputs = [
    ninja meson pkgconfig gcc7
  ];

  checkPhase = ''
    ninja test
  '';

  buildInputs = [ nix boost python3 ];
  src = filterMesonBuild ./.;
}

{ pkgs, build_systems, ... }:

let
  makeOptionsDoc = configuration: pkgs.nixosOptionsDoc { inherit (configuration) options lib; };
  example = makeOptionsDoc (build_systems [ "example" ] ../example/.)."example";
in
pkgs.stdenvNoCC.mkDerivation {
  name = "dashNix-book";
  src = ./.;

  patchPhase = ''
    sed '/*Declared by:*/,/^$/d' <${example.optionsCommonMark} >> src/dashNix.md
  '';
  buildPhase = ''
    ${pkgs.mdbook}/bin/mdbook build --dest-dir $out
  '';
}

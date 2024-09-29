# with friendly help by stylix: https://github.com/danth/stylix/blob/master/docs/default.nix
{
  pkgs,
  build_systems,
  lib,
  ...
}:
let
  makeOptionsDoc = configuration: pkgs.nixosOptionsDoc { options = configuration; };
  generateDocs = obj: ''
    touch src/${obj.fst}.md
    sed '/*Declared by:*/,/^$/d' <${obj.snd.optionsCommonMark} >> src/${obj.fst}.md
  '';
  summaryAppend = name: ''
    echo "- [${name}](${name}.md)" >> src/SUMMARY.md
  '';
  system = (build_systems { root = ../example/.; })."example".options;
  makeOptionsDocPrograms = name: pkgs.nixosOptionsDoc { options = system.mods.${name}; };
  conf = makeOptionsDoc system.conf;
  paths = builtins.readDir ../modules/programs;
  names = lib.lists.remove "default" (
    map (name: lib.strings.removeSuffix ".nix" name) (lib.attrsets.mapAttrsToList (name: _: name) paths)
  );
  mods = map makeOptionsDocPrograms names;
  docs = lib.strings.concatLines (map generateDocs (lib.lists.zipLists names mods));
  summary = lib.strings.concatStringsSep " " (map summaryAppend names);
in
pkgs.stdenvNoCC.mkDerivation {
  name = "dashNix-book";
  src = ./.;

  patchPhase = ''
    sed '/*Declared by:*/,/^$/d' <${conf.optionsCommonMark} >> src/conf.md
    ${docs}
    echo "[README](README.md)\n # Options\n - [Base Config](conf.md)" >> src/SUMMARY.md
    ${summary}
  '';

  buildPhase = ''
    ${pkgs.mdbook}/bin/mdbook build --dest-dir $out
  '';
}

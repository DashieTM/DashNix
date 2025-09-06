# with friendly help by stylix: https://github.com/danth/stylix/blob/master/docs/default.nix
{
  pkgs,
  buildSystems,
  lib,
  ...
}: let
  makeOptionsDoc = configuration: pkgs.nixosOptionsDoc {options = configuration;};
  generateDocs = obj: ''
    touch src/${obj.fst}.md
    sed '/*Declared by:*/,/^$/d' <${obj.snd.optionsCommonMark} >> src/${obj.fst}.md
  '';
  summaryAppend = name: ''
    echo "- [${name}](${name}.md)" >> src/SUMMARY.md
  '';
  system = (buildSystems {root = ../example/.;})."example".options;
  makeOptionsDocPrograms = names: pkgs.nixosOptionsDoc {options = lib.attrByPath (lib.splitString "." names) null system.mods;};
  conf = makeOptionsDoc system.conf;
  basePath = ../modules/programs;
  pathToAttrs = path:
    lib.attrsets.mapAttrsToList (
      name: meta: {
        inherit name;
        inherit meta;
      }
    )
    (builtins.readDir path);
  pathToStrings = path: prefix: let
    mapFn = attrs:
      if attrs.meta == "directory"
      then pathToStrings "${basePath}/${attrs.name}" attrs.name
      else if prefix != ""
      then "${prefix}.${attrs.name}"
      else attrs.name;
  in
    map
    mapFn
    (pathToAttrs path);
  filteredNames = builtins.filter (names: !(lib.strings.hasInfix "default" names)) (
    map (name: lib.strings.removeSuffix ".nix" name) (lib.lists.flatten (pathToStrings basePath ""))
  );
  deduplicatedNames = map (name: lib.strings.splitString "." name |> lib.lists.unique |> lib.strings.concatStringsSep ".") filteredNames;
  mods = map makeOptionsDocPrograms deduplicatedNames;
  docs = lib.strings.concatLines (map generateDocs (lib.lists.zipLists deduplicatedNames mods));
  summary = lib.strings.concatStringsSep " " (map summaryAppend deduplicatedNames);
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

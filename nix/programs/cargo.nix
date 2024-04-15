{ lib
, fetchCrate
, rustPlatform
, ...
}: {
  home.packages = [
    rustPlatform.buildRustPackage
    rec {
      pname = "oxinoti";
      version = "0.1.1";
      src = fetchCrate {
        inherit pname version;
        hash = lib.fakehash;
      };
    }
    #rustPlatform.buildRustPackage
    #{
    #  pname = "oxidash";
    #  version = "0.1.0";
    #  #src = fetchCrate {
    #  #  inherit name version;
    #  #  sha256 = lib.fakesha256;
    #  #};
    #}
    #rustPlatform.buildRustPackage
    #{
    #  pname = "oxishut";
    #  version = "0.1.0";
    #  #src = fetchCrate {
    #  #  inherit name version;
    #  #  sha256 = lib.fakesha256;
    #  #};
    #}
  ];
}


{ pkgs, ... }:
let
  # credit to benley: https://github.com/benley/dotfiles/commit/325748c3a8553d55c9fab08654a77b252aa0fde7
  patched_ssdt = pkgs.stdenv.mkDerivation {
    name = "patched_ssdt";
    src = ./.;
    buildInputs = [ pkgs.libarchive ];
    installPhase = ''
      mkdir -p kernel/firmware/acpi
      cp ${./ssdt6.aml} kernel/firmware/acpi/ssdt6.aml
      mkdir -p $out
      echo kernel/firmware/acpi/ssdt6.aml | bsdcpio -v -o -H newc -R 0:0 > $out/lenotrolli-ssdt.img
    '';
  };
in

{
  boot.kernelParams = [ "mem_sleep_default=deep" ];
  boot.initrd.prepend = [ "${patched_ssdt}/lenotrolli-ssdt.img" ];
}

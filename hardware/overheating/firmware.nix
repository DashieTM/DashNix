{ pkgs, ... }: {
  hardware.firmware = [
    (
      # lenovo is such a good manufacturer!!1!11!
      # credit for the binary files: https://github.com/darinpp/yoga-slim-7
      pkgs.stdenv.mkDerivation {
        name = "firmware-lenotrolli";
        src = ./firmware;
        installPhase = ''
          mkdir -p $out/lib/firmware
          cp ${./firmware/TAS2XXX38BB.bin} $out/lib/firmware/TAS2XXX38BB.bin
          cp ${./firmware/TIAS2781RCA4.bin} $out/lib/firmware/TIAS2781RCA4.bin
        '';
      })
  ];
}

{
  imports =
    [
      ./dsdt.nix
      ./firmware.nix
    ];
  # special hardware modules
  # TODO: needed?
  boot.kernelModules = [ "kvm-amd" ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  # for hyprdock
  services.acpid.enable = true;
}

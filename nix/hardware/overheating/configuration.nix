{
  imports = [
    ../../modules/conf.nix
    ./dsdt.nix
    ./firmware.nix
  ];
  conf = {
    monitor = "eDP-1";
    scale = "2.0";
    hostname = "overheating";
    boot_params = [ "rtc_cmos.use_acpi_alarm=1" ];
  };

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  # for hyprdock
  services.acpid.enable = true;
}

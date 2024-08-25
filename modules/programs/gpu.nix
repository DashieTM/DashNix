{
  lib,
  config,
  options,
  pkgs,
  ...
}:
{

  options.mods = {
    nvidia.enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
      example = true;
      description = ''
        Enables nvidia support.
      '';
    };
    amdgpu.enable = lib.mkOption {
      default = false;
      type = lib.types.bool;
      example = true;
      description = ''
        Enables amdgpu support.
      '';
    };
    vapi = {
      enable = lib.mkOption {
        default = false;
        type = lib.types.bool;
        example = true;
        description = ''
          Enables vapi.
        '';
      };
      rocm.enable = lib.mkOption {
        default = false;
        type = lib.types.bool;
        example = true;
        description = ''
          Enables rocm support.
        '';
      };
    };
  };

  config = lib.mkIf config.mods.vapi.enable (
    lib.optionalAttrs (options ? hardware.graphics) {
      boot = lib.mkIf config.mods.amdgpu.enable {
        kernelModules = [ "kvm-amd" ];
        initrd.kernelModules = [ "amdgpu" ];
        kernelParams = [ "amdgpu.ppfeaturemask=0xffffffff" ];
      };

      hardware = {
        graphics =
          let
            base_packages = [
              pkgs.libvdpau-va-gl
              pkgs.vaapiVdpau
              pkgs.mesa.drivers
            ];
            rocm_packages = [
              pkgs.rocmPackages.clr.icd
              pkgs.rocm-opencl-runtime
            ];
          in
          {
            enable = true;
            enable32Bit = lib.mkDefault true;
            extraPackages = base_packages ++ (lib.lists.optionals config.mods.vapi.rocm.enable rocm_packages);
          };
      };
    }
    // lib.optionalAttrs (options ? hardware.graphics) (
      lib.mkIf config.mods.nvidia.enable {
        hardware.nvidia = {
          modesetting.enable = true;
          # powerManagement.enable = false;
          # powerManagement.finegrained = true;
          open = true;
          nvidiaSettings = true;
          package = config.boot.kernelPackages.nvidiaPackages.beta;
        };
        services.xserver.videoDrivers = [ "nvidia" ];
      }
    )
  );
}

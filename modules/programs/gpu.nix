{
  lib,
  config,
  options,
  pkgs,
  ...
}: {
  options.mods = {
    gpu = {
      nvidia.enable = lib.mkOption {
        default = false;
        example = true;
        type = lib.types.bool;
        description = ''
          Enables nvidia support.
        '';
      };
      amdgpu.enable = lib.mkOption {
        default = false;
        example = true;
        type = lib.types.bool;
        description = ''
          Enables amdgpu support.
        '';
      };
      intelgpu.enable = lib.mkOption {
        default = false;
        example = true;
        type = lib.types.bool;
        description = ''
          Enables intel support.
        '';
      };
      vapi = {
        enable = lib.mkOption {
          default = true;
          example = false;
          type = lib.types.bool;
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
  };

  config =
    (lib.optionalAttrs (options ? hardware.graphics) {
      boot = lib.mkIf config.mods.amdgpu.enable {
        kernelModules = ["kvm-amd"];
        initrd.kernelModules = ["amdgpu"];
        kernelParams = ["amdgpu.ppfeaturemask=0xffffffff"];
      };

      hardware = {
        graphics = let
          amdPackages = [
            (lib.mkIf (config.mods.gpu.intelgpu && lib.mkIf config.mods.gpu.vapi.enable) pkgs.vpl-gpu-rt)
            (lib.mkIf (
                config.mods.gpu.intelgpu && lib.mkIf config.mods.gpu.vapi.enable
              )
              pkgs.intel-media-driver)
            (lib.mkIf config.mods.gpu.vapi.enable pkgs.libvdpau-va-gl)
            (lib.mkIf config.mods.gpu.vapi.enable pkgs.vaapiVdpau)
            (lib.mkIf (config.mods.gpu.intelgpu || config.mods.gpu.amdgpu) pkgs.mesa.drivers)
          ];
          rocmPackages = [
            pkgs.rocmPackages.clr.icd
            pkgs.rocm-opencl-runtime
          ];
        in {
          enable = true;
          enable32Bit = lib.mkDefault true;
          extraPackages =
            amdPackages
            ++ (lib.lists.optionals (config.mods.gpu.vapi.rocm.enable && config.mods.gpu.amdgpu) rocmPackages);
        };
      };
    })
    // lib.optionalAttrs (options ? hardware.graphics) (
      lib.mkIf config.mods.gpu.nvidia.enable {
        hardware.nvidia = {
          modesetting.enable = true;
          # powerManagement.enable = false;
          # powerManagement.finegrained = true;
          open = true;
          nvidiaSettings = true;
          package = config.boot.kernelPackages.nvidiaPackages.beta;
        };
        services.xserver.videoDrivers = ["nvidia"];
      }
    );
}

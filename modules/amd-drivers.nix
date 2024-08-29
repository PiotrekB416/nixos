{
  lib,
  pkgs,
  config,
  ...
}:
with lib;
let
    cfg = config.drivers.amdgpu;
in
{
    options.drivers.amdgpu = {
        enable = mkEnableOption "Enable AMD Drivers";
    };

    config = mkIf cfg.enable {
        boot.initrd.kernelModules = [ "amdgpu" ];

        hardware.graphics.extraPackages = with pkgs; [
            rocmPackages.clr.icd
            rocm-opencl-icd
            rocm-opencl-runtime
            amdvlk
        ];
        systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
        services.xserver.videoDrivers = [ "amdgpu" ];
    };
}


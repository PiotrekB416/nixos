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
        systemd.tmpfiles.rules = [ "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}" ];
        services.xserver.videoDrivers = [ "amdgpu" ];
        hardware.graphics.extraPackages = with pkgs; [
            rocmPackages.clr.icd
            # amdvlk
        ];
        hardware.graphics.extraPackages32 = with pkgs; [
            # driversi686Linux.amdvlk
        ];
        environment.systemPackages = with pkgs; [
            vulkan-tools
            clinfo
        ];
        # environment.variables = {
        #     VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/amd_icd64.json";
        # };
    };
}


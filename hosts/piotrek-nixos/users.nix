{
  pkgs,
  username,
  ...
}:

let
  inherit (import ./variables.nix) gitUsername;
in
{
    users.users = {
        "${username}" = {
            homeMode = "755";
            isNormalUser = true;
            description = "${gitUsername}";
            extraGroups = [
                "networkmanager"
                "wheel"
                "libvirtd"
                "scanner"
                "lp"
                "adbusers"
                "plugdev"
                "docker"
                "audio"
                "input"
                "uinput"
            ];
            shell = pkgs.zsh;
            ignoreShellProgramCheck = true;
            packages = with pkgs; [
            ];
        };
    };
}

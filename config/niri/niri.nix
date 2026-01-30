{
  lib,
  username,
  host,
  config,
  inputs,
  pkgs,
  ...
}:

let
  inherit (import ../../hosts/${host}/variables.nix)
    browser
    terminal
    extraMonitorSettings
    keyboardLayout
    ;
in
with lib;
{
    # programs.niri = {
    #     #enable = true;
    #     #package = pkgs.niri;
    #     #systemd.enable = true;
    # #};
    # #home.file.".config/hypr/hyprland.conf".text = ''
    #     config = null;
    # };
    home.file.".config/niri/config.kdl".text = ''
binds {
    Mod+T hotkey-overlay-title="Open a Terminal: ${terminal}" { spawn "${terminal}"; }
    Mod+W hotkey-overlay-title="Open Browser: ${browser}" { spawn "${browser}"; }
}

include "./keybinds.kdl"
include "./misc.kdl"
include "./extra.kdl"
    '';

    home.file.".config/niri/keybinds.kdl".source = ./keybinds.kdl;
    home.file.".config/niri/misc.kdl".source = ./misc.kdl;
}

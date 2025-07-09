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
    wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        extraConfig = ''
            $modifier = SUPER
            $terminal = ${terminal}
            $browser = ${browser}
            $extraMonitorSettings = ${extraMonitorSettings}
            $keyboardLayout = ${keyboardLayout}

            source = ~/.config/hypr/monitors.conf
            source = ~/.config/hypr/execs.conf
            source = ~/.config/hypr/keybinds.conf
        '';
        systemd.enable = true;
        xwayland.enable = true;
    };

    home.file.".config/hypr/keybinds.conf".source = ./keybinds.conf;
    home.file.".config/hypr/execs.conf".source = ./execs.conf;
}

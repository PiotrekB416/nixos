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
    wayland.windowManager.mango = {
        enable = true;
        systemd.enable = true;
#         settings = ''
# bind=SUPER,W,spawn,${browser}
# bind=SUPER,T,spawn,${terminal}
#
# source=./extra.conf
# source=./env.conf
# source=./execs.conf
# source=./keybinds.conf
# source=./misc.conf
#         '';
        settings = ''
source = ./dms/colors.conf
source = ./dms/layout.conf
source = ./dms/outputs.conf
source = ./dms/cursor.conf
source = ./dms/binds.conf
        '';
    };
    # home.file.".config/mango/env.conf".source = ./env.conf;
    # home.file.".config/mango/execs.conf".source = ./execs.conf;
    # home.file.".config/mango/keybinds.conf".source = ./keybinds.conf;
    # home.file.".config/mango/misc.conf".source = ./misc.conf;
}

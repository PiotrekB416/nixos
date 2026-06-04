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
        extraConfig = ''
bind=SUPER,W,spawn,${browser}
bind=SUPER,T,spawn,${terminal}

source = ./extra.conf
source = ./env.conf
source = ./keybinds.conf
source = ./misc.conf
        '';
    };
    home.file.".config/mango/env.conf".source = ./env.conf;
    home.file.".config/mango/keybinds.conf".source = ./keybinds.conf;
    home.file.".config/mango/misc.conf".source = ./misc.conf;
}

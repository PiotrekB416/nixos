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
    keyboardLayout
    ;
in
with lib;
{
    wayland.windowManager.hyprland = {
        enable = true;
        systemd.enable = true;
        configType = "lua";
    #};
    #home.file.".config/hypr/hyprland.conf".text = ''
        extraConfig = ''
MODIFIER = "SUPER"
TERMINAL = "${terminal}"
BROWSER = "${browser}"
KEYBOARD_LAYOUT = "${keyboardLayout}"
      
require("misc")
-- require("env")
require("keybinds")
require("extra")

      '';
    };
# source = ./extra.conf
# source = ./env.lua
# source = ./misc.lua
# source = ./keybinds.lua
#     '';
#     };
#     home.file.".config/hypr/env.conf".source = ./env.conf;
     home.file.".config/hypr/misc.lua".source = ./misc.lua;
     home.file.".config/hypr/keybinds.lua".source = ./keybinds.lua;
#
#
#     home.file.".config/hypr/scripts/wsaction.fish" = {
#         executable = true;
#         text = ''
# #!/usr/bin/env fish
#
# if test "$argv[1]" = '-g'
#     set group
#     set -e $argv[1]
# end
#
# if test (count $argv) -ne 2
#     echo 'Wrong number of arguments. Usage: ./wsaction.fish [-g] <dispatcher> <workspace>'
#     exit 1
# end
#
# set -l active_ws (hyprctl activeworkspace -j | jq -r '.id')
#
# if set -q group
#     # Move to group
#     hyprctl dispatch $argv[1] (math "($argv[2] - 1) * 10 + $active_ws % 10")
# else
#     # Move to ws in group
#     hyprctl dispatch $argv[1] (math "floor(($active_ws - 1) / 10) * 10 + $argv[2]")
# end
#     '';
#     };
#
#     home.file.".config/hypr/scripts/sysmon.fish" = {
#         executable = true;
#         text = ''
# #!/usr/bin/env fish
#
# set -l sysmon_data (hyprctl workspaces -j | jq 'map(select(.name == "special:sysmon")).[0]')
#
# if string match -q "null" $sysmon_data
#     echo 'workspace not open'
#     exit
# end
#
# set -l windows (echo $sysmon_data | jq '.windows')
#
# echo $windows
#
# if test "$windows" = 0
#     exec alacritty --class sysmon -e 'btop'
# end
#         '';
#     };
}

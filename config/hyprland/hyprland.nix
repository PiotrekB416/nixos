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
    home.file.".config/hypr/hyprland.conf".text = ''
$modifier = SUPER
$terminal = ${terminal}
$browser = ${browser}
$extraMonitorSettings = ${extraMonitorSettings}
$keyboardLayout = ${keyboardLayout}

source = ~/.config/hypr/monitors.conf
source = ~/.config/hypr/env.conf
source = ~/.config/hypr/execs.conf
source = ~/.config/hypr/keybinds.conf
    '';
    home.file.".config/hypr/env.conf".source = ./env.conf;
    home.file.".config/hypr/execs.conf".source = ./execs.conf;
    home.file.".config/hypr/keybinds.conf".source = ./keybinds.conf;


    home.file.".config/hypr/scripts/wsaction.fish" = {
        executable = true;
        text = ''
#!/usr/bin/env fish

if test "$argv[1]" = '-g'
    set group
    set -e $argv[1]
end

if test (count $argv) -ne 2
    echo 'Wrong number of arguments. Usage: ./wsaction.fish [-g] <dispatcher> <workspace>'
    exit 1
end

set -l active_ws (hyprctl activeworkspace -j | jq -r '.id')

if set -q group
    # Move to group
    hyprctl dispatch $argv[1] (math "($argv[2] - 1) * 10 + $active_ws % 10")
else
    # Move to ws in group
    hyprctl dispatch $argv[1] (math "floor(($active_ws - 1) / 10) * 10 + $argv[2]")
end
    '';
    };
}

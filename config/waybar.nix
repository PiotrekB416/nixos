{
  pkgs,
  lib,
  host,
  config,
  ...
}:

let
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
  inherit (import ../hosts/${host}/variables.nix) clock24h terminal;
in
with lib;
{
    programs.waybar = {
        enable = true;
        package = pkgs.waybar;
        settings = [{
            layer = "top";
            posistion = "top";
#            module-left = [ "hyprland/workspaces" ];
#            module-center = [ "clock" ];
#            module-rigth = [
#                "memory"
#                "cpu"
#                "battery"
#                "pulseaudio"
#                "backlight"
#                "network"
#            ];
            modules-center = [ "hyprland/workspaces" ];
            modules-left = [
                "custom/startmenu"
                "pulseaudio"
                "cpu"
                "memory"
                "idle_inhibitor"
            ];
            modules-right = [
                "custom/notification"
                "battery"
                "tray"
                "clock"
            ];

            "hyprland/workspaces" = {
                format = "{name}";
                format-icons = {
                    default = " ";
                    active = " ";
                    urgent = " ";
                };
                on-scroll-up = "hyprctl dispatch workspace e+1";
                on-scroll-down = "hyprctl dispatch workspace e-1";
            };
            "clock" = {
                format = if clock24h == true then '' {:L%H:%M}'' else '' {:L%I:%M %p}'';
                tooltip = true;
                tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
            };
            "memory" = {
                interval = 5;
                format = " {}%";
                tooltip = true;
                on-click = "${terminal} -e btop";
            };
            "cpu" = {
                interval = 5;
                format = " {usage:2}%";
                tooltip = true;
                on-click = "${terminal} -e btop";
            };
            "disk" = {
                format = " {free}";
                tooltip = true;
                on-click = "${terminal} -e btop";
            };
            "network" = {
                format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
                format-ethernet = " {bandwidthDownOctets}";
                format-wifi = "{icon} {signalStrength}%";
                format-disconnected = "󰤮";
                tooltip = false;
            };
            "tray" = {
                spacing = 12;
            };
            "pulseaudio" = {
                format = "{icon} {volume}% {format_source}";
                format-bluetooth = "{volume}% {icon} {format_source}";
                format-bluetooth-muted = " {icon} {format_source}";
                format-muted = " {format_source}";
                format-source = " {volume}%";
                format-source-muted = "";
                format-icons = {
                    headphone = "";
                    hands-free = "";
                    headset = "";
                    phone = "";
                    portable = "";
                    car = "";
                    default = [ "" "" "" ];
                };
                on-click = "sleep 0.1 && pavucontrol";
            };
            "custom/startmenu" = {
                tooltip = false;
                format = "";
                # exec = "rofi -show drun";
                on-click = "sleep 0.1 && rofi-launcher";
            };
            "custom/notification" = {
                tooltip = false;
                format = "{icon} {}";
                format-icons = {
                    notification = "<span foreground='red'><sup></sup></span>";
                    none = "";
                    dnd-notification = "<span foreground='red'><sup></sup></span>";
                    dnd-none = "";
                    inhibited-notification = "<span foreground='red'><sup></sup></span>";
                    inhibited-none = "";
                    dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
                    dnd-inhibited-none = "";
                };
                return-type = "json";
                exec-if = "which swaync-client";
                exec = "swaync-client -swb";
                on-click = "sleep 0.1 && task-waybar";
                escape = true;
            };
            "idle_inhibitor" = {
                format = "{icon}";
                format-icons = {
                    activated = "";
                    deactivated = "";
                };
                tooltip = "true";
            };
            "battery" = {
                states = {
                    warning = 30;
                    critical = 15;
                };
                format = "{icon} {capacity}%";
                format-charging = "󰂄 {capacity}%";
                format-plugged = "󱘖 {capacity}%";
                format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
                on-click = "";
                tooltip = false;
            };
        }];
        style = ''
            * {
                font-family: JetBrainsMono Nerd Font Mono;
                font-size: 16px;
                border-radius: 0px;
                border: none;
                min-height: 0px;
            }
            window#waybar {
                background: rgba(0,0,0,0);
            }
            #workspaces {
                color: #000000;
                background: #303030;
                margin: 4px 4px;
                padding: 5px 5px;
                border-radius: 16px;
            }
            #workspaces button {
                font-weight: bold;
                padding: 0px 5px;
                margin: 0px 3px;
                border-radius: 16px;
                color: #000000;
                background: #1a8fff;
                opacity: 0.5;
                transition: ${betterTransition};
            }
            #workspaces button.active {
                font-weight: bold;
                padding: 0px 5px;
                margin: 0px 3px;
                border-radius: 16px;
                color: #000000;
                background: #1a8fff;
                transition: ${betterTransition};
                opacity: 1.0;
                min-width: 40px;
            }
            #workspaces button:hover {
                font-weight: bold;
                border-radius: 16px;
                color: #000000;
                background: #1a8fff;
                opacity: 0.8;
                transition: ${betterTransition};
            }
            tooltip {
                background: #000000;
                border: 1px solid #f5f5f5;
                border-radius: 12px;
            }
            tooltip label {
              color: #f5f5f5;
            }
            #window, #pulseaudio, #cpu, #memory, #idle_inhibitor {
                font-weight: bold;
                margin: 4px 0px;
                margin-left: 7px;
                padding: 0px 18px;
                background: #d0d0d0;
                color: #000000;
                border-radius: 24px 10px 24px 10px;
            }
            #custom-startmenu {
                color: #14ffff;
                background: #505050;
                font-size: 28px;
                margin: 0px;
                padding: 0px 30px 0px 15px;
                border-radius: 0px 0px 40px 0px;
            }
            #custom-hyprbindings, #network, #battery,
            #custom-notification, #tray, #custom-exit {
                font-weight: bold;
                background: #be643c;
                color: #000000;
                margin: 4px 0px;
                margin-right: 7px;
                border-radius: 10px 24px 10px 24px;
                padding: 0px 18px;
            }
            #clock {
                font-weight: bold;
                color: #0D0E15;
                background: #1a8fff;
                margin: 0px;
                padding: 0px 15px 0px 30px;
                border-radius: 0px 0px 0px 40px;
            }
          '';
    };
}

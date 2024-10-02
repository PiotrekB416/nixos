{
  lib,
  username,
  host,
  config,
  ...
}:

let
  inherit (import ../hosts/${host}/variables.nix)
    browser
    terminal
    extraMonitorSettings
    keyboardLayout
    monitors
    ;
in
with lib;
{
    wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        systemd.enable = true;
        extraConfig =
        let
            modifier = "SUPER";
        in
        concatStrings [
            ''
            env = NIXOS_OZONE_WL, 1
            env = NIXPKGS_ALLOW_UNFREE, 1
            env = XDG_CURRENT_DESKTOP, Hyprland
            env = XDG_SESSION_TYPE, wayland
            env = XDG_SESSION_DESKTOP, Hyprland
            env = GDK_BACKEND, wayland, x11
            env = CLUTTER_BACKEND, wayland
            env = QT_QPA_PLATFORM=wayland;xcb
            env = QT_WAYLAND_DISABLE_WINDOWDECORATION, 1
            env = QT_AUTO_SCREEN_SCALE_FACTOR, 1
            env = SDL_VIDEODRIVER, x11
            env = MOZ_ENABLE_WAYLAND, 1
            exec-once = dbus-update-activation-environment --systemd --all
            exec-once = systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
            exec-once = killall -q swww;sleep .5 && swww init
            exec-once = killall -q waybar;sleep .5 && waybar
            exec-once = killall -q swaync;sleep .5 && swaync
            exec-once = nm-applet --indicator
            exec-once = lxqt-policykit-agent
            exec-once = sleep 1.5 && swww img /home/${username}/Pictures/Wallpapers/wallpaper-0.jpg
            #monitor=,preferred,auto,1
            ${monitors}
            exec-once = wl-paste --type text --watch cliphist store #Stores only text data
            exec-once = wl-paste --type image --watch cliphist store #Stores only image data

            general {
                gaps_in = 2
                gaps_out = 5
                border_size = 3
                col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
                col.inactive_border = rgba(595959aa)

                layout = dwindle
            }
            input {
                kb_layout = ${keyboardLayout}
                kb_variant =
                kb_model =
                kb_options =
                kb_rules =

                follow_mouse = 1

                touchpad {
                    natural_scroll = yes
                    disable_while_typing = no
                }

                sensitivity = -0.15 # -1.0 - 1.0, 0 means no modification.
            }
            windowrule = noborder,^(wofi)$
            windowrule = center,^(wofi)$
            windowrule = center,^(steam)$
            windowrule = float, nm-connection-editor|blueman-manager
            windowrule = float, swayimg|vlc|Viewnior|pavucontrol
            windowrule = float, nwg-look|qt5ct|mpv
            windowrule = float, zoom
            windowrulev2 = stayfocused, title:^()$,class:^(steam)$
            windowrulev2 = minsize 1 1, title:^()$,class:^(steam)$

            windowrulev2 = float,class:^(firefox)$,title:^(Picture-in-Picture)$
            windowrulev2 = keepaspectratio,class:^(firefox)$,title:^(Picture-in-Picture)$,floating:1
            windowrulev2 = suppressevent fullscreen,class:^(firefox)$,title:^(Picture-in-Picture)$
            windowrulev2 = pin,class:^(firefox)$,title:^(Picture-in-Picture)$

            windowrulev2 = suppressevent fullscreen,class:^(astro-win64-shipping.exe)$
            windowrulev2 = tile,class:^(astro-win64-shipping.exe)$

            windowrulev2 = float,class:^(nm-connection-editor)$,title:^(Network Connections)$
            windowrulev2 = move 69.5% 4%,class:^(nm-connection-editor)$,title:^(Network Connections)$
            windowrulev2 = size 30% 30%,class:^(nm-connection-editor)$,title:^(Network Connections)$
            windowrulev2 = rounding 0,class:^(nm-connection-editor)$,title:^(Network Connections)$
            windowrulev2 = pin,class:^(nm-connection-editor)$,title:^(Network Connections)$

            windowrulev2 = suppressevent fullscreen,class:^(org.kde.dolphin)$

            windowrulev2 = float,class:^(org.kde.plasmawindowed)$,title:^(Calendar)$
            windowrulev2 = move 32.5% 4%,class:^(org.kde.plasmawindowed)$,title:^(Calendar)$
            windowrulev2 = size 35% 40%,class:^(org.kde.plasmawindowed)$,title:^(Calendar)$
            windowrulev2 = rounding 0,class:^(org.kde.plasmawindowed)$,title:^(Calendar)$

            gestures {
                workspace_swipe = true
                workspace_swipe_fingers = 3
            }


#           animations {
#               enabled = yes


#               bezier = myBezier, 0.05, 0.9, 0.1, 1.05

#               animation = windows, 1, 7, myBezier
#               animation = windowsOut, 1, 7, default, popin 80%
#               animation = border, 1, 10, default
#               animation = fade, 1, 7, default
#               animation = workspaces, 1, 6, default
#           }
            animations {
                enabled = yes
                bezier = wind, 0.05, 0.9, 0.1, 1
                bezier = winIn, 0.1, 1, 0.1, 1
                bezier = winOut, 0.3, -0.3, 0, 1
                bezier = liner, 1, 1, 1, 1
                animation = windows, 1, 6, wind
                animation = windowsIn, 1, 6, winIn
                animation = windowsOut, 1, 5, winOut
                animation = windowsMove, 1, 5, wind
                animation = border, 1, 1, liner
                animation = fade, 1, 10, default
                animation = workspaces, 1, 5, wind
            }


            decoration {
                rounding = 10
                    blur {
                        enabled = true
                        size = 8
                        passes = 1
                        new_optimizations = true
                    }

                drop_shadow = yes
                shadow_range = 4
                shadow_render_power = 3
                col.shadow = rgba(1a1a1aee)
            }


            dwindle {
                pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                preserve_split = yes # you probably want this
            }

            master {
                new_status = master
            }

            # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
            bind = ${modifier}, Q, exec, ${terminal}
            bind = ${modifier}, X, exit,
            bind = ${modifier}, E, exec, dolphin
            bind = ${modifier}, V, togglefloating,
            bind = ${modifier}, P, pin, # dwindle
            bind = ${modifier}, J, togglesplit, # dwindle
            bind = ALT, F4, killactive,
            bind = ${modifier}, F, exec, GDK_DPI_SCALE=1 ${browser} -P piotrek
            bind = ${modifier}, b, fullscreen, 1
            bind = ${modifier} SHIFT, b, fullscreen
            bind = ${modifier},code:60,exec,emopicker9000
            bind = ${modifier} SHIFT, s, exec, screenshootin
            bind = ${modifier}, space, exec, playerctl play-pause
            #memes - the dna of the soul
            #bind = ${modifier} SHIFT ALT CTRL, L, exec, xdg-open https://linkedin.com


            # Move focus with mainMod + arrow keys
            bind = ${modifier}, left, movefocus, l
            bind = ${modifier}, right, movefocus, r
            bind = ${modifier}, up, movefocus, u
            bind = ${modifier}, down, movefocus, d

            # Switch workspaces with mainMod + [0-9]
            bind = ${modifier}, 1, workspace, 1
            bind = ${modifier}, 2, workspace, 2
            bind = ${modifier}, 3, workspace, 3
            bind = ${modifier}, 4, workspace, 4
            bind = ${modifier}, 5, workspace, 5
            bind = ${modifier}, 6, workspace, 6
            bind = ${modifier}, 7, workspace, 7
            bind = ${modifier}, 8, workspace, 8
            bind = ${modifier}, 9, workspace, 9
            bind = ${modifier}, 0, togglespecialworkspace
            bind = ${modifier}, grave, togglespecialworkspace
            bind = CTRL ALT, Tab, workspace, e+1
            bind = CTRL ALT SHIFT, Tab, workspace, e-1

            # Move active window to a workspace with mainMod + SHIFT + [0-9]
            bind = ${modifier} SHIFT, 1, movetoworkspace, 1
            bind = ${modifier} SHIFT, 2, movetoworkspace, 2
            bind = ${modifier} SHIFT, 3, movetoworkspace, 3
            bind = ${modifier} SHIFT, 4, movetoworkspace, 4
            bind = ${modifier} SHIFT, 5, movetoworkspace, 5
            bind = ${modifier} SHIFT, 6, movetoworkspace, 6
            bind = ${modifier} SHIFT, 7, movetoworkspace, 7
            bind = ${modifier} SHIFT, 8, movetoworkspace, 8
            bind = ${modifier} SHIFT, 9, movetoworkspace, 9
            bind = ${modifier} SHIFT, 0, movetoworkspace, special
            bind = ${modifier} SHIFT, grave, movetoworkspace, special

            # Scroll through existing workspaces with mainMod + scroll
            bind = ${modifier}, mouse_down, workspace, e+1
            bind = ${modifier}, mouse_up, workspace, e-1

            # Move/resize windows with mainMod + LMB/RMB and dragging
            bindm = ${modifier}, mouse:272, movewindow
            bindm = ${modifier}, mouse:273, resizewindow
            bindm = ${modifier} CTRL, mouse:272, resizewindow

            # volume
            bind =, XF86AudioLowerVolume, exec, pamixer --decrease 5
            bind =, XF86AudioLowerVolume, exec, amixer -q sset Master unmute
            bind =, XF86AudioRaiseVolume, exec, pamixer --increase 5
            bind =, XF86AudioRaiseVolume, exec, amixer -q sset Master unmute

            bind =, XF86AudioPlay, exec, playerctl play-pause
            bind = ,XF86AudioPlay, exec, playerctl play-pause
            bind = ,XF86AudioPause, exec, playerctl play-pause
            bind = ,XF86AudioNext, exec, playerctl next
            bind = ,XF86AudioPrev, exec, playerctl previous


            bind =, XF86MonBrightnessDown, exec, brightnessctl set 5%-
            bind =, XF86MonBrightnessUp, exec, brightnessctl set 5%+
            ''
        ];
    };
}

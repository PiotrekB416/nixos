{ inputs, config, pkgs, ... }: {
  home.file = {
      ".config/hypr/hyprland.conf".text = ''
    # This is an example Hyprland config file.
    #
    # Refer to the wiki for more information.

    #
    # Please note not all available settings / options are set here.
    # For a full list, see the wiki
    #

    # See httpis://wiki.hyprland.org/Configuring/Monitors/
    monitor=,preferred,auto,1
    #monitor=,preferred,auto,auto

    # See https://wiki.hyprland.org/Configuring/Keywords/ for more

    # Execute your favorite apps at launch
    # exec-once = waybar & hyprpaper & firefox
    #exec-once = waybar
    #exec-once = hyprctl keyword monitor ",preferred,auto,1"
    exec-once = dbus-update-activation-environment --all
    exec-once = gnome-keyring-daemon --start --components=secrets
    #exec-once = /usr/lib/pam_kwallet_init
    exec-once = hyprctl setcursor elementary 30
    exec-once = gsettings set org.gnome.desktop.interface cursor-theme elementary
    exec-once = bash ~/.config/eww/scripts/launch_volume
    #exec-once = bash ~/.config/hypr/flameshot
    exec-once = /usr/lib/polkit-kde-authentication-agent-1
    exec-once = bash /home/piotrek/.config/hypr/xdg
    exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
    exec-once = nm-applet --indicator
    exec-once = waybar
    #exec-once = bash ~/.config/eww/scripts/lauch_dashboard
    #exec-once = bash /usr/lib/pam_kwallet_init
    exec-once = dunst -config ~/.config/dunst/dunstrc
    #exec-once = hyprpaper
    exec-once = swww init & swww img ~/.local/share/backgrounds/2023-01-01-00-38-37-3840x2560.jpg
    exec-once = swayidle before-sleep 'bash ~/.local/bin/lock' after-resume 'bluetoothctl connect 98:52:3D:6C:67:C2' & disown

    exec-once = wl-paste --type text --watch cliphist store #Stores only text data
    exec-once = wl-paste --type image --watch cliphist store #Stores only image data

    # Source a file (multi-file configs)
    # source = ~/.config/hypr/myColors.conf

    # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
    input {
        kb_layout = pl
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

    misc {
        #enable_swallow = 1
        #swallow_regex = ^(Alacritty)$
    }

    general {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

        gaps_in = 2
        gaps_out = 5
        border_size = 3
        col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
        col.inactive_border = rgba(595959aa)

        layout = dwindle
    }

    decoration {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more

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

    animations {
        enabled = yes

        # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = myBezier, 0.05, 0.9, 0.1, 1.05

        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default
    }

    dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = yes # you probably want this
    }

    master {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_is_master = true
    }

    gestures {
        # See https://wiki.hyprland.org/Configuring/Variables/ for more
        workspace_swipe = on
    }


    # Example per-device config
    # See https://wiki.hyprland.org/Configuring/Keywords/#executing for more
#    device:epic mouse V1 {
#        sensitivity = -0.5
#    }


    # Example windowrule v1
    # windowrule = float, ^(kitty)$
    # Example windowrule v2
    # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
    # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

    #windowrulev2 = suppressevent fullscreen,class:^(.*)$

    #windowrulev2 = unset,class:^(firefox)$

    windowrulev2 = noborder, fullscreen:1

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

    windowrulev2 = forceinput, class:^(jetbrains-idea)$

    #windowrulev2 = float,class:^(Alacritty)$
    #windowrulev2 = tile,class:^(Alacritty)$
    #windowrulev2 = noborder,class:^(org.kde.plasmawindowed)$,title:^(Networks)$

    # See https://wiki.hyprland.org/Configuring/Keywords/ for more
    $mainMod = SUPER

    # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
    bind = $mainMod, Q, exec, alacritty -e launch-zellij
    bind = $mainMod SHIFT, Q, exec, alacritty
    #bind = $mainMod, C, killactive,
    bind = $mainMod, X, exit,
    bind = $mainMod, E, exec, index
    bind = $mainMod, V, togglefloating,
    #bind = $mainMod, R, exec, wofi --show run
    bind = $mainMod, P, pin, # dwindle
    bind = $mainMod, J, togglesplit, # dwindle
    bind = ALT, F4, killactive,
    bind = $mainMod, F, exec, GDK_DPI_SCALE=1 firefox -P piotrek
    #bind = $mainMod, d, exec, bash ~/.config/eww/scripts/launch_dashboard
    bind = $mainMod, b, fullscreen, 1
    bind = $mainMod SHIFT, b, fullscreen
    #bind = $mainMod SHIFT, s, exec, env XDG_CURRENT_DESKTOP=sway QT_SCALE_FACTOR=1.5 flameshot gui
    #bind = $mainMod SHIFT, s, exec, env QT_SCALE_FACTOR=1 QT_FONT_DPI=130 flameshot gui
    bind = $mainMod SHIFT, s, exec, grim -g "$(slurp)" - | swappy -f -
    bind = $mainMod, space, exec, playerctl play-pause
    #bind = $mainMod SHIFT ALT CTRL, L, exec, xdg-open https://linkedin.com


    # Move focus with mainMod + arrow keys
    bind = $mainMod, left, movefocus, l
    bind = $mainMod, right, movefocus, r
    bind = $mainMod, up, movefocus, u
    bind = $mainMod, down, movefocus, d

    # Switch workspaces with mainMod + [0-9]
    bind = $mainMod, 1, workspace, 1
    bind = $mainMod, 2, workspace, 2
    bind = $mainMod, 3, workspace, 3
    bind = $mainMod, 4, workspace, 4
    bind = $mainMod, 5, workspace, 5
    bind = $mainMod, 6, workspace, 6
    bind = $mainMod, 7, workspace, 7
    bind = $mainMod, 8, workspace, 8
    bind = $mainMod, 9, workspace, 9
    bind = $mainMod, 0, togglespecialworkspace
    bind = $mainMod, grave, togglespecialworkspace
    bind = CTRL ALT, Tab, workspace, e+1
    bind = CTRL ALT SHIFT, Tab, workspace, e-1

    # Move active window to a workspace with mainMod + SHIFT + [0-9]
    bind = $mainMod SHIFT, 1, movetoworkspace, 1
    bind = $mainMod SHIFT, 2, movetoworkspace, 2
    bind = $mainMod SHIFT, 3, movetoworkspace, 3
    bind = $mainMod SHIFT, 4, movetoworkspace, 4
    bind = $mainMod SHIFT, 5, movetoworkspace, 5
    bind = $mainMod SHIFT, 6, movetoworkspace, 6
    bind = $mainMod SHIFT, 7, movetoworkspace, 7
    bind = $mainMod SHIFT, 8, movetoworkspace, 8
    bind = $mainMod SHIFT, 9, movetoworkspace, 9
    bind = $mainMod SHIFT, 0, movetoworkspace, special
    bind = $mainMod SHIFT, grave, movetoworkspace, special

    # Scroll through existing workspaces with mainMod + scroll
    bind = $mainMod, mouse_down, workspace, e+1
    bind = $mainMod, mouse_up, workspace, e-1

    # Move/resize windows with mainMod + LMB/RMB and dragging
    bindm = $mainMod, mouse:272, movewindow
    bindm = $mainMod, mouse:273, resizewindow
    bindm = $mainMod CTRL, mouse:272, resizewindow

    # volume
    bind =, XF86AudioLowerVolume, exec, pamixer --decrease 5
  # bind =, XF86AudioLowerVolume, exec, amixer -q sset Master unmute
    bind =, XF86AudioLowerVolume, exec, bash $XDG_CONFIG_HOME/eww/scripts/volume
    bind =, XF86AudioRaiseVolume, exec, pamixer --increase 5
    bind =, XF86AudioRaiseVolume, exec, amixer -q sset Master unmute
    bind =, XF86AudioRaiseVolume, exec, bash $XDG_CONFIG_HOME/eww/scripts/volume
    bind =, XF86AudioMute, exec,


    bind =, XF86MonBrightnessDown, exec, brightnessctl set 5%-
    bind =, XF86MonBrightnessDown, exec, bash $XDG_CONFIG_HOME/eww/scripts/brightness
    bind =, XF86MonBrightnessUp, exec, brightnessctl set 5%+
    bind =, XF86MonBrightnessUp, exec, bash $XDG_CONFIG_HOME/eww/scripts/brightness

    # SUBMAP RESIZE
    bind = ALT, R, submap, resize
    submap = resize

    binde = , right, resizeactive, 10 0
    binde = , left, resizeactive, -10 0
    binde = , up, resizeactive, 0 -10
    binde = , down, resizeactive, 0 10

    bind = ALT, R, submap, reset
    bind = , escape, submap, reset

    submap = reset

  ''; };
}

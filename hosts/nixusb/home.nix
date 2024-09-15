{
  config,
  pkgs,
  username,
  host,
  ...
}:
let
    inherit (import ./variables.nix) gitUsername gitEmail;
in
{
    imports = [
        ../../config/hyprland.nix
        ../../config/zellij.nix
        ../../config/emoji.nix
 #       ../../config/neovim.nix
        ../../config/rofi/rofi.nix
        ../../config/rofi/config-emoji.nix
        ../../config/rofi/config-long.nix
        ../../config/swaync.nix
        ../../config/waybar.nix
    ];
    programs.home-manager.enable = true;
    # Home Manager Settings
    home.username = "${username}";
    home.homeDirectory = "/home/${username}";
    home.stateVersion = "23.05";
    home.file."Pictures/Wallpapers" = {
        source = ../../config/wallpapers;
        recursive = true;
    };

    home.file.".config/swappy/config".text = ''
        [Default]
        save_dir=/home/${username}/Pictures/Screenshots
        save_filename_format=swappy-%Y%m%d-%H%M%S.png
        show_panel=false
        line_size=5
        text_size=20
        text_font=Ubuntu
        paint_mode=brush
        early_exit=true
        fill_shape=false
    '';

    stylix.targets.waybar.enable = false;
    stylix.targets.rofi.enable = false;
    stylix.targets.hyprland.enable = false;
    stylix.targets.neovim.enable = false;
    stylix.targets.btop.enable = false;

    programs.git = {
        enable = true;
        userName = "${gitUsername}";
        userEmail = "${gitEmail}";
    };

    programs.fastfetch.enable = true;

    xdg = {
        userDirs = {
            enable = true;
            createDirectories = true;
        };
    };

    dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
            autoconnect = [ "qemu:///system" ];
            uris = [ "qemu:///system" ];
        };
    };

    gtk = {
        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
        };
        gtk3.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
        };
        gtk4.extraConfig = {
            gtk-application-prefer-dark-theme = 1;
        };
    };
    qt = {
        enable = true;
        style.name = "adwaita-dark";
        platformTheme.name = "gtk3";
    };

    services = {
        hypridle = {
            settings = {
                general = {
                    after_sleep_cmd = "hyprctl dispatch dpms on";
                    ignore_dbus_inhibit = false;
                    lock_cmd = "hyprlock";
                };
                listener = [
                  {
                    timeout = 900;
                    on-timeout = "hyprlock";
                  }
                  {
                    timeout = 1200;
                    on-timeout = "hyprctl dispatch dpms off";
                    on-resume = "hyprctl dispatch dpms on";
                  }
                ];
            };
        };
    };

    programs = {
        gh.enable = true;
        btop = {
            enable = true;
            settings = {
                color_theme = "TTY";
                theme_background = false;
                vim_keys = true;
                update_ms = 1000;
            };
        };
        alacritty = {
            enable = true;
            settings = {
#               colors = {
#                   bright = {
#                       black = "#767676";
#                       blue = "#1a8fff";
#                       cyan = "#14ffff";
#                       green = "#23fd00";
#                       magenta = "#fd28ff";
#                       red = "#f2201f";
#                       white = "#ffffff";
#                       yellow = "#fffd00";
#                   };
#                   cursor = {
#                       cursor = "#ffffff";
#                       text = "#aaaaaa";
#                   };
#                   normal = {
#                       black = "#000000";
#                       blue = "#0d73cc";
#                       cyan = "#0dcdcd";
#                       green = "#19cb00";
#                       magenta = "#cb1ed1";
#                       red = "#cc0403";
#                       white = "#dddddd";
#                       yellow = "#cecb00";
#                   };
#                   primary = {
#                       background = "#000000";
#                       foreground = "#dddddd";
#                   };
#               };
                window.opacity = 0.75;
                font.size = 15;
            };
        };
        zsh = {
            enable = true;
            enableCompletion = true;
            syntaxHighlighting.enable = true;
            autosuggestion.enable = true;
            shellAliases = {
                exa = "eza";
                vim = "nvim";
                vi = "nvim";
                ".." = "cd ..";
            };
            history = {
                size = 10000;
                path = "${config.xdg.dataHome}/zsh/history";
            };
            autocd = true;

            initExtra = ''bindkey "''${key[Up]}" up-line-or-search'';
        };
        hyprlock.enable = true;
        mpv = {
            enable = true;
            scripts = with pkgs.mpvScripts; [
                mpris
            ];
        };
    };

    home.packages = [
        (import ../../scripts/emopicker9000.nix { inherit pkgs; })
        (import ../../scripts/task-waybar.nix { inherit pkgs; })
#        (import ../../scripts/web-search.nix { inherit pkgs; })
        (import ../../scripts/rofi-launcher.nix { inherit pkgs; })
        (import ../../scripts/screenshootin.nix { inherit pkgs; })
    ];

}

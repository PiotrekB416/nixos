{
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
        #../../config/fastfetch
        ../../config/neovim.nix
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
        source = ../..config/Wallpapers;
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
                vim-keys = true;
            };
        };
        alacritty = {
            enable = true;
            settings = {
                colors = {
                    bright = {
                        black = "#767676";
                        blue = "#1a8fff";
                        cyan = "#14ffff";
                        green = "#23fd00";
                        magenta = "#fd28ff";
                        red = "#f2201f";
                        white = "#ffffff";
                        yellow = "#fffd00";
                    };
                    cursor = {
                        cursor = "#ffffff";
                        text = "#aaaaaa";
                    };
                    normal = {
                        black = "#000000";
                        blue = "#0d73cc";
                        cyan = "#0dcdcd";
                        green = "#19cb00";
                        magenta = "#cb1ed1";
                        red = "#cc0403";
                        white = "#dddddd";
                        yellow = "#cecb00";
                    };
                    primary = {
                        background = "#000000";
                        foreground = "#dddddd";
                    };
                };
                window.opacity = 0.75;
                font.size = 15;
            };
        };
        zsh = {
            enable = true;
            enableCompletion = true;
            syntaxHighlighting = true;
            shellAliases = {
                exa = "eza";
                ".." = "cd ..";
            };
        };
        hyprlock.enable = true;
    };
}

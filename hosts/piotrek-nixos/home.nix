{
  config,
  pkgs,
  username,
  host,
  inputs,
  home,
  ...
}:
let
    inherit (import ./variables.nix) gitUsername gitEmail;
in
{
    imports = [
        ../../config/hyprland/hyprland.nix
        ../../config/niri/niri.nix
        ../../config/zellij.nix
        ../../config/emoji.nix
#        ({config, ...}: let
#            undodir = "${config.home.homeDirectory}/.vim/undodir";
#        in import ../../config/nixvim {
#            inherit undodir pkgs config inputs;
#        })
#        ../../config/neovim.nix
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
    home.sessionPath = [
        "/home/${username}/.local/bin"
        "/home/${username}/.cargo/bin"
    ];

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
    stylix.targets.hyprlock.enable = false;
    stylix.targets.firefox.enable = false;
    stylix.targets.qt.enable = false;

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
        alacritty = {
            enable = true;
            settings = {
                scrolling.multiplier = 15;
            };
        };
        neovim = {
            enable = true;
            viAlias = true;
            vimAlias = true;
            defaultEditor = true;
        };
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
        wezterm = {
            enable = true;
            package = inputs.wezterm.packages.${pkgs.system}.default;
            extraConfig = ''
                local wezterm = require 'wezterm'
                local config = wezterm.config_builder()
                local act = wezterm.action

                config.default_prog = { "fish" }
                config.enable_tab_bar = false
                config.front_end = "OpenGL"
                config.window_close_confirmation = "NeverPrompt"
                config.window_padding = {
                    left = 0,
                    right = 0,
                    top = 0,
                    bottom = 0,
                }
                config.keys = {
                    { key = 'V', mods = 'CTRL|SHIFT', action = act.EmitEvent('execute-paste') },
                }

                wezterm.on('execute-paste', function(window, pane)
                    local success, stdout, stderr = wezterm.run_child_process({"wl-paste", "--no-newline"})
                    if success then
                        pane:paste(stdout)
                    else
                        wezterm.log_error("wl-paste failed with\n" .. stderr .. stdout)
                    end
                end)

                return config
            '';
        };
        zsh = {
            enable = true;
            enableCompletion = true;
            syntaxHighlighting.enable = true;
            autosuggestion.enable = true;
            shellAliases = {
                exa = "eza";
		        vi = "nvim";
		        vim = "nvim";
                ".." = "cd ..";
                nix-zellij = "nix develop --command \"zsh\" \"-c\" \"launch-zellij --layout programming\"";
            };
            history = {
                size = 10000;
                path = "${config.xdg.dataHome}/zsh/history";
            };
            autocd = true;

            initExtra = ''
            bindkey "''${key[Up]}" up-line-or-search
            bindkey "''${key[Down]}" down-line-or-search
            '';
        };
        fish = {
            enable = true;
            shellAliases = {
                exa = "eza";
                ".." = "cd ..";
                nix-zellij = "nix develop --command \"fish\" \"-c\" \"launch-zellij --new-session-with-layout programming\"";
            };
            shellInitLast = ''
                set fish_greeting
            '';
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

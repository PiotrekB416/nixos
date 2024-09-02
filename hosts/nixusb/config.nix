{
    config,
    pkgs,
    host,
    username,
    options,
    modulesPath,
    system,
    ...
}:
let
    inherit (import ./variables.nix) keyboardLayout;
in
{
    imports = [
	./hardware.nix
        ./users.nix
        ../../modules/amd-drivers.nix
        ../../modules/nvidia-drivers.nix
        ../../modules/nvidia-prime-drivers.nix
        ../../modules/intel-drivers.nix
        ../../modules/vm-guest-services.nix
        ../../modules/local-hardware-clock.nix
    ];
    boot = {
        loader.systemd-boot.enable = true;
        loader.efi.canTouchEfiVariables = true;

        kernel.sysctl = {
            "vm.max_map_count" = 2147483642;
        };

        kernelPackages = pkgs.linuxPackages_latest;

        binfmt.registrations.appimage = {
            wrapInterpreterInShell = false;
            interpreter = "${pkgs.appimage-run}/bin/appimage-run";
            recognitionType = "magic";
            offset = 0;
            mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
            magicOrExtension = ''\x7fELF....AI\x02'';
        };
    };
nixpkgs.hostPlatform = system;
      stylix = {
    enable = true;
    image = ../../config/wallpapers/wallpaper-0.jpg;
    base16Scheme = {
base00= "000000";
base01= "303030";
base02= "505050";
base03= "b0b0b0";
base04= "d0d0d0";
base05= "e0e0e0";
base06= "f5f5f5";
base07= "ffffff";
base08= "f2201f";
base09= "fda331";
base0A= "fffd00";
base0B= "23fd00";
base0C= "14ffff";
base0D= "1a8fff";
base0E= "fd28ff";
base0F= "be643c";
    };
    polarity = "dark";
    opacity.terminal = 0.75;
    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Ice";
    cursor.size = 24;
    fonts = {
      monospace = {
        #package = pkgs.nerdfonts.override { fonts = [ "Noto" ]; };
        #name = "NotoMono Nerd Font Mono";
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "NotoSans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "NotoSerif";
      };
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };
  };

    # Extra Module Options
    drivers.amdgpu.enable = false;
    drivers.nvidia.enable = false;
    drivers.nvidia-prime = {
        enable = false;
        intelBusID = "";
        nvidiaBusID = "";
    };
    drivers.intel.enable = false;
    vm.guest-services.enable = false;
    local.hardware-clock.enable = false;

    # Enable networking
    networking.networkmanager.enable = true;
    networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

    networking.hostName = host;

    time.timeZone = "Europe/Warsaw";

    i18n.defaultLocale = "en_GB.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "pl_PL.UTF-8";
        LC_IDENTIFICATION = "pl_PL.UTF-8";
        LC_MEASUREMENT = "pl_PL.UTF-8";
        LC_MONETARY = "pl_PL.UTF-8";
        LC_NAME = "pl_PL.UTF-8";
        LC_NUMERIC = "pl_PL.UTF-8";
        LC_PAPER = "pl_PL.UTF-8";
        LC_TELEPHONE = "pl_PL.UTF-8";
        LC_TIME = "pl_PL.UTF-8";
    };

    programs = {
        firefox.enable = true;
        starship = {
            enable = true;
            settings = {
                add_newline = false;
                buf = {
                    symbol = " ";
                };
                c = {
                    symbol = " ";
                };
                directory = {
                    read_only = " 󰌾";
                };
                docker_context = {
                    symbol = " ";
                };
                fossil_branch = {
                    symbol = " ";
                };
                git_branch = {
                    symbol = " ";
                };
                golang = {
                    symbol = " ";
                };
                hg_branch = {
                    symbol = " ";
                };
                hostname = {
                    ssh_symbol = " ";
                };
                lua = {
                    symbol = " ";
                };
                memory_usage = {
                    symbol = "󰍛 ";
                };
                meson = {
                    symbol = "󰔷 ";
                };
                nim = {
                    symbol = "󰆥 ";
                };
                nix_shell = {
                    symbol = " ";
                };
                nodejs = {
                    symbol = " ";
                };
                ocaml = {
                    symbol = " ";
                };
                package = {
                    symbol = "󰏗 ";
                };
                python = {
                    symbol = " ";
                };
                rust = {
                    symbol = " ";
                };
                swift = {
                    symbol = " ";
                };
                zig = {
                    symbol = " ";
                };
            };
        };
        dconf.enable = true;
        seahorse.enable = true;
        fuse.userAllowOther = true;
        mtr.enable = true;
        gnupg.agent = {
            enable = true;
            enableSSHSupport = true;
        };
        virt-manager.enable = true;
        steam = {
            enable = true;
            gamescopeSession.enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
        };

        nix-ld = {
           enable = true;

           libraries = with pkgs; [
             alsa-lib
             at-spi2-atk
             at-spi2-core
             atk
             cairo
             cups
             curl
             dbus
             expat
             fontconfig
             freetype
             fuse3
             gdk-pixbuf
             glib
             gtk3
             icu
             libGL
             libappindicator-gtk3
             libdrm
             libglvnd
             libnotify
             libpulseaudio
             libunwind
             libusb1
             libuuid
             libxkbcommon
             mesa
             nspr
             nss
             openssl
             pango
             pipewire
             stdenv.cc.cc
             systemd
             vulkan-loader
             xorg.libX11
             xorg.libXScrnSaver
             xorg.libXcomposite
             xorg.libXcursor
             xorg.libXdamage
             xorg.libXext
             xorg.libXfixes
             xorg.libXi
             xorg.libXrandr
             xorg.libXrender
             xorg.libXtst
             xorg.libxcb
             xorg.libxkbfile
             xorg.libxshmfence
             zlib
           ];
         };
         zsh.enable = true;
         adb.enable = true;
    };

    nixpkgs.config.allowUnfree = true;
    fonts = {
        packages = with pkgs; [
            noto-fonts-emoji
            noto-fonts-cjk
            font-awesome
            material-icons
        ];
    };
    users = {
        mutableUsers = true;
    };

    xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal
        ];
        configPackages = [
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal-hyprland
            pkgs.xdg-desktop-portal
        ];
    };

    environment.systemPackages = with pkgs; [
        wget
        git
        qt5ct
        brightnessctl
        zip
        unzip
        networkmanagerapplet
        home-manager
        playerctl
        pavucontrol
        rofi
        swaynotificationcenter

        starship
        swww
        eww
        dunst
        wl-clipboard
        pamixer
        dolphin
        jdk21
        nasm

        wine64
        gcc
        gdb
        clang-tools
        gnumake
        rustup
        github-desktop
        github-cli
        dotnet-sdk_8
        python311Full
        python311Packages.pip

        android-studio
        android-tools

        neovim
        eza
        virt-manager
        libreoffice
        distrobox

        grim slurp swappy
        haskellPackages.kmonad
        gamescope
        appimage-run
        ((stremio.overrideAttrs (prev: rec {
            server = fetchurl {
                url = "https://s3-eu-west-1.amazonaws.com/stremio-artifacts/four/v${prev.version}/server.js";
                sha256 = "sha256-7XmbXW50a6LV0724bxJsT3f5+9d44anoh1l1aIW98us=";
                postFetch = ''
                    substituteInPlace $out --replace-fail "/usr/bin/mpv" "/etc/profiles/per-user/piotrek/bin/mpv"
                '';
            };
        })))
        zellij
        docker-compose
        ripgrep
    ];

    services = {
        getty.autologinUser = username;
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            wireplumber.configPackages = [
                (pkgs.writeTextDir
                "wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
                    bluez_monitor.properties = {
                        --["bluez5.enable-sbc-xq"] = true,
                        --["bluez5.enable-msbc"] = true,
                        ["bluez5.enable-hw-volume"] = false,
                        --["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
                    }
                '')
            ];
        };
        xserver = {
            enable = true;
            displayManager.startx.enable = true;
            #desktopManager.plasma5.enable = true;
            xkb = {
                layout = "${keyboardLayout}";
                variant = "";
                options = "compose:ralt";
            };
        };
        libinput.enable = true;
        fstrim.enable = true;
        gvfs.enable = true;
        openssh.enable = true;
        flatpak.enable = true;
        playerctld.enable = true;
        gnome.gnome-keyring.enable = true;
        blueman.enable = true;
        avahi = {
            enable = true;
            nssmdns4 = true;
            openFirewall = true;
        };
        openvpn.servers = {
            homeVPN = {
                config = ''config /home/piotrek/.openvpn/home.ovpn'';
                autoStart = false;
            };
        };
    };
    systemd.services.flatpak-repo = {
        path = [ pkgs.flatpak ];
        script = ''
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        '';
    };

    hardware = {
        printers = {
            ensurePrinters = [{
                name = "Samsung_CLP-320";
                location = "Home";
                deviceUri = "http://192.168.1.125:631/printers/Samsung_CLP-320_Series";
                model = "drv:///sample.drv/generic.ppd";
                ppdOptions = {
                   PageSize = "A4";
                };
            }];
            ensureDefaultPrinter = "Samsung_CLP-320";
        };
        graphics = {
            enable = true;
            enable32Bit = true;
        };
        pulseaudio.enable = false;
        bluetooth = {
            enable = true;
            powerOnBoot = true;
        };
    };

    nix = {
        settings = {
            auto-optimise-store = true;
            experimental-features = [
                "nix-command"
                "flakes"
            ];
            substituters = [ "https://hyprland.cachix.org" ];
            trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
        };
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 7d";
        };
    };

    virtualisation = {
        libvirtd.enable = true;
        podman = {
            enable = true;
            dockerCompat = true;
            defaultNetwork.settings.dns_enabled = true;
        };
    };

    console.keyMap = "${keyboardLayout}";

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?
}

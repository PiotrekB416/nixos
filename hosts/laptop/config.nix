{
    config,
    pkgs,
    host,
    username,
    options,
    inputs,
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

 	initrd.luks.devices."luks-e446b62d-f8c1-453c-9793-fee59cfd5e0c" = {
		device = "/dev/disk/by-uuid/e446b62d-f8c1-453c-9793-fee59cfd5e0c";
		preLVM = true;
	};
  	supportedFilesystems = [ "btrfs" ];

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

    stylix = {
    	enable = true;
    	image = ../../config/wallpapers/wallpaper-0.jpg;
    	base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    	polarity = "dark";
    	opacity.terminal = 0.9;
    	cursor.package = pkgs.bibata-cursors;
    	cursor.name = "Bibata-Modern-Ice";
    	cursor.size = 36;
    	fonts = {
      	    monospace = {
            	package = pkgs.nerd-fonts.jetbrains-mono;
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
            	terminal = 22;
            	desktop = 17;
        	    popups = 18;
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
    drivers.intel.enable = true;
    vm.guest-services.enable = false;
    local.hardware-clock.enable = false;

    # Enable networking
    networking.networkmanager = {
        enable = true;
        plugins = with pkgs; [
            networkmanager-openvpn
        ];
    };
    networking.timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];

    networking.hostName = host;
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 22 ];
        extraCommands = ''
            iptables -I OUTPUT 1 -m owner --gid-owner no-internet -j DROP
            ip6tables -I OUTPUT 1 -m owner --gid-owner no-internet -j DROP
        '';
    };

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
             skia
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
        fish.enable = true;
        hyprland = {
            enable = true;
            withUWSM = true;
            xwayland.enable = true;
        };
        niri.enable = true;
        gamemode.enable = true;
        kdeconnect.enable = true;
    };

    nixpkgs.config = {
        allowUnfree = true;
        android_sdk.accept_license = true;
    };
    fonts = {
        packages = with pkgs; [
            noto-fonts-color-emoji
            noto-fonts-cjk-sans
            font-awesome
            material-icons
            material-symbols
            nerd-fonts.jetbrains-mono
            ibm-plex
        ];
    };
    users = {
        mutableUsers = true;
        groups.no-internet = {};
    };

    xdg.portal = {
        xdgOpenUsePortal = false;
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
        libsForQt5.qt5ct
        brightnessctl
        zip
        unzip
        networkmanagerapplet
        home-manager
        playerctl
        pavucontrol
        rofi
        swaynotificationcenter

        swww
        eww
        dunst
        wl-clipboard
        pamixer
        kdePackages.dolphin
        kdePackages.qt6ct
        kdePackages.qt5compat
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
        #python3
        (python3.withPackages (ps: with ps; [
            pip
            materialyoucolor
            aubio
            sounddevice
            pyaudio
            numpy
        ]))

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
#       ((stremio.overrideAttrs (prev: rec {
#           server = fetchurl {
#               url = "https://s3-eu-west-1.amazonaws.com/stremio-artifacts/four/v${prev.version}/server.js";
#               sha256 = "sha256-R7WU8F0KIQuuSYr8TTQrXa/Q9oarXBWold/W95c6DDA=";
#               postFetch = ''
#                   substituteInPlace $out --replace-fail "/usr/bin/mpv" "/etc/profiles/per-user/piotrek/bin/mpv"
#               '';
#           };
#       })))
        zellij
        podman-compose docker-compose
        ripgrep
	    wineWow64Packages.full winetricks
        qbittorrent-nox
        dialog
        freerdp
        iproute2
        libnotify
        nmap
        tree-sitter
        nwg-displays
        pkg-config
        openssl.dev
        starship
        texlive.combined.scheme-medium
        poppler poppler-utils
        typst
        tinymist
        prismlauncher
        librewolf
        #firefox #while they work on cache
        nodejs
        go
        kdePackages.plasma-workspace
        inputs.quickshell.packages.${pkgs.system}.default
        cliphist
        imagemagick
        fuzzel
        socat
        jq
        xdg-user-dirs
        wayfreeze
        wl-screenrec
        fd
        ddcutil
        cava
        lm_sensors
        app2unit
        lutris mangohud
        vulkan-tools
        sdl3
        adwaita-icon-theme
        gtk3
        glib
        gsettings-desktop-schemas
        godot
        ncdu
        dgop
        linux-wallpaperengine
        xwayland-satellite
    ];

    services = {
        #getty.autologinUser = username;
        pipewire = {
            enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
            pulse.enable = true;
            jack.enable = true;
            wireplumber.extraConfig.bluetoothEnhancements = {
                "monitor.bluez.properties" = {
                    #"bluez5.enable-sbc-xq" = true;
                    #"bluez5.enable-msbc" = true;
                    "bluez5.enable-hw-volume" = false;
                    #"bluez5.roles" = [ "hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag" ];
                };
            };
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
        # avahi = {
        #     enable = true;
        #     nssmdns4 = true;
        #     openFirewall = true;
        # };
        printing = {
            enable = true;
            drivers = with pkgs; [
                samsung-unified-linux-driver_1_00_37
                samsung-unified-linux-driver
            ];
        };
        upower.enable = true;
        accounts-daemon.enable = true;
        power-profiles-daemon.enable = true;
        input-remapper.enable = true;
    };
    systemd.services = {
        flatpak-repo = {
            path = [ pkgs.flatpak ];
            script = ''
                flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            '';
        };
        "getty@tty1" = {
            overrideStrategy = "asDropin";
            serviceConfig.ExecStart = ["" "@${pkgs.util-linux}/sbin/agetty agetty --login-program ${config.services.getty.loginProgram} --autologin piotrek --noclear --keep-baud %I 115200,38400,9600 $TERM"];
        };
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
            substituters = [
                "https://hyprland.cachix.org"
                #"https://nix-community.cachix.org"
            ];
            trusted-public-keys = [
                "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                #"nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            ];
            trusted-users = [
                "root" "${username}"
            ];
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
            #dockerCompat = true;
            defaultNetwork.settings.dns_enabled = true;
        };
        docker = {
            enable = true;
            rootless = {
                enable = true;
                setSocketVariable = true;
            };
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

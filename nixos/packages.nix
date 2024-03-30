{ config, pkgs, inputs, outputs, ... }:
{
  services.mysql.enable = true;
  services.mysql.package = pkgs.mariadb;
  services.flatpak.enable = true;
  services.openssh.enable = true;
  services.samba-wsdd.enable = true; # make shares visible for windows 10 clients
  networking.firewall.allowedTCPPorts = [
    5357 # wsdd
  ];
  networking.firewall.allowedUDPPorts = [
    3702 # wsdd
  ];
  services.samba = {
    enable = true;
    securityType = "user";
    extraConfig = ''
      workgroup = NIXOS
      server string = smbnix
      netbios name = smbnix
      security = user
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 192.168.1.1/16 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
    '';
    shares = {
      public = {
        path = "/home/piotrek/Programming";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0777";
        "directory mask" = "0777";
        "force user" = "piotrek";
      };
    };
  };

  #virtualisation.oci-containers.containers = {
  #    pihole = {
  #      image = "pihole/pihole:latest";
  #      ports = [
  #        "127.0.0.1:53:53/tcp"
  #        "127.0.0.1:53:53/udp"
  #        "3080:80"
  #        "30443:443"
  #      ];
  #      volumes = [
  #        "/home/piotrek/docker/pihole/etc-pihole/:/etc/pihole/"
  #        "/home/piotrek/docker/pihole/etc-dnsmasq.d:/etc/dnsmasq.d/"
  #      ];
  #      extraOptions = [
  #        "--cap-add=NET_ADMIN"
  #        "--dns=127.0.0.1"
  #        "--dns=1.1.1.1"
  #      ];
  #  };
  #};
  #systemd.services.podman-pihole.serviceConfig.TimeoutStopSec = lib.mkForce 5;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.adb.enable = true;

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };
  hardware.opengl.driSupport32Bit = true; # Enables support for 32bit libs that steam uses
  #fonts.packages = with pkgs; [
  #  noto-nerdfont
  #]
  virtualisation.libvirtd.enable = true;
  virtualisation.docker = {
      enable = true;
      storageDriver = "btrfs";
  };
  virtualisation.waydroid.enable = true;
  programs.dconf.enable = true;
  xdg.portal = { enable = true; extraPortals = with pkgs; [ xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-wlr xdg-desktop-portal-kde]; };
  programs.zsh.enable = true;

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  #systemd.services."getty@tty1".enable = false;
  #systemd.services."autovt@tty1".enable = false;

  programs.nix-ld.enable = true;

  # Sets up all the libraries to load
  programs.nix-ld.libraries = with pkgs; [
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


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    qt5ct
    brightnessctl
    zip
    unzip
    networkmanagerapplet
    home-manager

    #hyprland
    swww
    alacritty
    nerdfonts
    #(nerdfonts.override { fonts = [ "Noto" ]; })
    zellij
    eww
    waybar
    dunst
    wl-clipboard cliphist
    btop
    pamixer
    index-fm
    starship
    jdk20
    wofi
    nasm

    #programming
    wine64
    gcc
    gdb
    clang-tools
    gnumake
    rustup
    jetbrains.idea-ultimate
    jetbrains.rider
    jetbrains.pycharm-professional
    github-desktop
    github-cli
    dotnet-sdk_8
    python311Full
    python311Packages.pip
    ((pkgs.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: rec {
                src = (builtins.fetchTarball {
                  url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
                  sha256 = "066ni98xg3wx9rzz919rdfgh0sdzv549jmqjl7knd98954s9pfbi";
                });
                version = "latest";

                buildInputs = oldAttrs.buildInputs ++ [ pkgs.krb5 ];
              }))

    #andoid
    androidStudioPackages.dev
    android-tools

    #misc
    firefox
    neovim
    eza
    virt-manager
    libreoffice
    distrobox
    #screen
    #obs-studio
    #obs-studio-plugins.obs-gstreamer
    #gst_all_1.gstreamer
    grim slurp swappy
    ripgrep
    i3
    nodejs_20
    appimage-run
    swaylock-effects swayidle
  ];
}

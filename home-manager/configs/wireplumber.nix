{ inputs, config, pkgs, ... }: {
    home.file.".config/wireplumber/wireplumber.conf.d/80-bluez-properties.conf".text = ''
        monitor.bluez.properties {
            bluez5.enable-hw-volume = false
        }
    '';
}

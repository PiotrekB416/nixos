{ inputs, config, pkgs, ... }: {
  home.file.".local/bin/tty1" = {
        text = ''
            #!/bin/bash

            if [ -f /tmp/tty1-autologin ] ; then
                exec ${pkgs.util-linux}/sbin/agetty -n -o piotrek --noclear --keep-baud tty1 115200,38400,9600 $TERM
            else
                date &> /tmp/tty1-autologin
                exec ${pkgs.util-linux}/sbin/agetty '--autologin' 'piotrek' --noclear --keep-baud tty1 115200,38400,9600 $TERM
            fi
        '';
    };
}


{
  lib,
  username,
  host,
  config,
  ...
}:{
    services.hypridle = {
        enable = true;
        settings = {
            general = {
                lock_cmd = "pidof hyprlock || hyprlock";
                before_sleep_cmd = "loginctl lock-session";
                after_sleep_cmd = "hyprctl dispatch dpms on";
            };
        };
    };
    programs.hyprlock = {
        enable = true;
        settings = {
            background = [
              {
                monitor = "";
                path = "screenshot";
                blur_passes = 1; # 0 disables blurring
                blur_size = 7;
                noise = 1.17e-2;
              }
            ];
            label = [
              {
                monitor = "";
                text = ''cmd[update:1000] echo $(LC_ALL="en_GB.UTF-8" date +"%A, %d %B %Y")'';
                color = "rgba(242, 243, 244, 0.75)";
                font_size = 95;
                font_family = "JetBrains Mono";
                position = "0, 300";
                halign = "center";
                valign = "center";
              }
            ];
            input-field = {
                monitor = "";
                size = "200,50";
                outline_thickness = 2;
                dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
                dots_spacing = 0.35; # Scale of dots' absolute size, 0.0 - 1.0
                dots_center = true;
                outer_color = "rgba(0, 0, 0, 0)";
                inner_color = "rgba(0, 0, 0, 0.2)";
                font_color = "rgb(111, 45, 104)";
                fade_on_empty = false;
                rounding = -1;
                check_color = "rgb(30, 107, 204)";
                placeholder_text = ''<i><span foreground="##cdd6f4">Input Password...</span></i>'';
                hide_input = false;
                position = "0, -100";
                halign = "center";
                valign = "center";
            };
        };
    };
}

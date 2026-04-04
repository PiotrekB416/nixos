{ 
  config, 
  host,
  lib,
  ... 
}:

let
  inherit (import ../hosts/${host}/variables.nix)
    window_manager_cmd
    ;
in
with lib;
{
  home.file.".profile"= {
    text = ''
#start window manager automatically
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
  exec ${window_manager_cmd} && exit
fi
    '';
    executable = true;
  };
}

{ pkgs, inputs, ... }:
let
  finecmdline = pkgs.vimUtils.buildVimPlugin {
    name = "fine-cmdline";
    src = inputs.fine-cmdline;
  };
in
{
    programs.neovim = {
        enable = true;
        defaultEnable = true;
        viAlias = true;
        vimAlias = true;
        vimdiffAlias = true;
        withNodeJs = true;

        extraLuaConfig = pkgs.lib.fileContents ./nvim/init.lua;
    };
}

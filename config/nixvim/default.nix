{ pkgs, inputs, undodir ? "/dev/null", ... }:
{
    programs.nixvim = {
        enable = true;
        viAlias = true;
        vimAlias = true;

        globals = {
            netrw_browse_split = 0;
            netrw_banner = 0;
            netrw_winsize = 25;
            mapleader = " ";
        };

        clipboard = {
            register = "unnamedplus";
            providers.wl-copy.enable = true;
        };

        opts = {
            nu = true;
            relativenumber = true;
            tabstop = 4;
            softtabstop = 4;
            shiftwidth = 4;
            expandtab = true;

            smartindent = true;

            autoindent = true;

            wrap = false;

            swapfile = false;
            backup = false;
            undodir = undodir;
            undofile = true;

            hlsearch = true;
            incsearch = true;
            ignorecase = true;
            smartcase = true;

            termguicolors = true;

            scrolloff = 8;
            signcolumn = "yes";
            #isfname = ''<cmd>lua append(@-@)'';

            updatetime = 50;
        };
    };

    imports = [
        ./keymaps.nix
        ./plugins.nix
    ];
}

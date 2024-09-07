{ pkgs, ... }: {
    programs.nixvim.plugins = {
        packer.enable = true;
        lsp = {
            enable = true;
            servers = {
                ccls.enable = true;
                htmx.enable = true;
                java-language-server.enable = true;
                rust-analyzer = {
                    enable = true;
                    installCargo = true;
                    installRustc = true;
                };
                lua-ls.enable = true;
                zls.enable = true;
                csharp-ls.enable = true;
            };
        };
        telescope.enable = true;
        markdown-preview.enable = true;
        codeium-nvim.enable = true;
        trouble.enable = true;
        treesitter.enable = true;
        treesitter-context.enable = true;
        harpoon.enable = true;
        refactoring = {
            enable = true;
            enableTelescope = true;
        };
        undotree.enable = true;
        fugitive.enable = true;
        zen-mode.enable = true;
        cloak.enable = true;
        neo-tree = {
            enable = true;
            window.position = "current";
            closeIfLastWindow = true;
            filesystem.filteredItems = {
                hideDotfiles = false;
                hideGitignored = false;
                hideHidden = false;
            };
        };
    };
}

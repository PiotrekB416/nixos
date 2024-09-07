{ pkgs, ... }: {
    programs.nixvim.keymaps = [
        {
            action = "<cmd>Neotree toggle<CR>";
            key = "<leader>n";
            mode = ["n"];
        }
        {
            action = "<cmd>Neotree toggle position=left<CR>";
            key = "<leader>N";
            mode = ["n"];
        }
        {
            action = ":m '>+1<CR>gv=gv";
            key = "<leader>J";
            mode = ["v"];
        }
        {
            action = ":m '<-2<CR>gv=gv";
            key = "<leader>K";
            mode = ["v"];
        }
        {
            action = "mzJ`z";
            key = "<leader>J";
            mode = ["n"];
        }
        {
            action = "<C-d>zz";
            key = "<C-d>";
            mode = ["n"];
        }
        {
            action = "<C-u>zz";
            key = "<C-u>";
            mode = ["n"];
        }
        {
            action = "nzzzv";
            key = "n";
            mode = ["n"];
        }
        {
            action = "Nzzzv";
            key = "N";
            mode = ["n"];
        }
        {
            action = "<cmd>lua require('vim-with-me').StartVimWithMe()<CR>";
            key = "<leader>vwm";
            mode = ["n"];
        }
        {
            action = "<cmd>lua require('vim-with-me').StopVimWithMe()<CR>";
            key = "<leader>svwm";
            mode = ["n"];
        }
        {
            action = ''[["_dP]]'';
            key = "<leader>p";
            mode = ["x"];
        }
        {
            action = ''[["+y]]'';
            key = "<leader>y";
            mode = ["n" "v"];
        }
        {
            action = "<Esc>";
            key = "<C-c>";
            mode = ["i"];
        }
        {
            action = "nop";
            key = "Q";
            mode = ["n"];
        }
        {
            action = "<cmd>lua vim.lsp.buf.format<CR>";
            key = "<leader>f";
            mode = ["n"];
        }
        {
            action = "<cmd>cnext<CR>zz";
            key = "<C-k>";
            mode = ["n"];
        }
        {
            action = "<cmd>cprev<CR>zz";
            key = "<C-j>";
            mode = ["n"];
        }
        {
            action = "<cmd>lnext<CR>zz";
            key = "<leader>k";
            mode = ["n"];
        }
        {
            action = "<cmd>lprev<CR>zz";
            key = "<leader>j";
            mode = ["n"];
        }
        {
            action = ''[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]]'';
            key = "<leader>s";
            mode = ["n"];
        }
        {
            action = "<cmd>!chmod +x %<CR>";
            key = "<leader>x";
            mode = ["n"];
            options.silent = true;
        }
        {
            action = "<cmd>CellularAutomaton make_it_rain<CR>";
            key = "<leader>mr";
            mode = ["n"];
        }
    ];
}

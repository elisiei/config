{ pkgs, inputs, ... }:

# my most preciated config, well documented if you want to use it.
# inspired by https://github.com/xhuyz/nixvim

{
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;

    imports = [
      # plugins
      # ./plugins/aerial.nix
      ./plugins/autopairs.nix
      ./plugins/blink.nix
      ./plugins/dashboard.nix
      ./plugins/hlchunk.nix
      ./plugins/lualine.nix
      ./plugins/neo-tree.nix
      ./plugins/snacks.nix
      ./plugins/toggleterm.nix
      ./plugins/treesitter.nix
      ./plugins/treesj.nix
      ./plugins/web-devicons.nix
      ./plugins/yanky.nix

      # lsp
      ./lsp/fidget.nix
      ./lsp/lsp.nix
      ./lsp/roslyn.nix

      # keymaps
      ./keymaps.nix

      # themes
      ./themes.nix
    ];

    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = false;
      colorcolumn = "80";
      shiftwidth = 2;
      tabstop = 2;
      wrap = false;
      swapfile = false; # undotree
      backup = false; # undotree
      undofile = true;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      scrolloff = 8;
      signcolumn = "no";
      updatetime = 50;
      foldlevelstart = 99;
    };

    clipboard = {
      register = "unnamedplus";
    };

    extraPackages = with pkgs; [
      # formatters
      stylua
      nixfmt-rfc-style

      # linters
      golangci-lint
      shellcheck
    ];

    extraConfigLua = ''
            						vim.diagnostic.config({ virtual_lines = true })
            						vim.diagnostic.config({ virtual_text = true })
                  			vim.o.undofile = true
                  			vim.o.undodir = vim.fn.expand("~/.local/state/nvim/undo")
      									vim.diagnostic.config({ signs = false })
                  		'';
  };
}

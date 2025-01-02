# This is where the nvchad config is defined, in terms of nix modules
{...}: {
  # Plugin list built from
  # https://github.com/NvChad/starter/blob/main/init.lua
  # and
  # https://github.com/NvChad/NvChad/blob/v2.5/lua/nvchad/plugins/init.lua
  imports = [
    ./plugins/nvchad-starter-lazy.nix
    ./plugins/cmp.nix
    ./plugins/conform.nix
    ./plugins/gitsigns.nix
    ./plugins/indent-blankline.nix
    ./plugins/lspconfig.nix
    ./plugins/nvchad-base46.nix
    ./plugins/nvchad-menu.nix
    ./plugins/nvchad-minty.nix
    ./plugins/nvchad-ui.nix
    ./plugins/nvchad-volt.nix
    ./plugins/nvchad.nix
    ./plugins/nvimtree.nix
    ./plugins/plenary.nix
    ./plugins/telescope.nix
    ./plugins/treesitter.nix
    ./plugins/web-devicons.nix
    ./plugins/which-key.nix

    # Files for broader user-defined settings
    ./starter/chadrc.nix
    ./starter/mappings.nix
    ./starter/options.nix
  ];

  globals.base46_cache.__raw = ''vim.fn.stdpath "data" .. "/base46/"'';
  globals.mapleader = " ";

  plugins.lazy.enable = true;
  # plugins.lazy.enable = false;

  extraConfigLuaPost = ''
    dofile(vim.g.base46_cache .. "defaults")
    dofile(vim.g.base46_cache .. "statusline")

    require "nvchad.options"
    require "nvchad.autocmds"

    vim.schedule(function()
      require "mappings"
    end)
  '';
}

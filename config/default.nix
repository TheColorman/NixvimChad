{pkgs, ...}@args: let
  inherit (pkgs.vimPlugins) nvchad;
  nvchad-init = import ./nvchad-init.nix args;

  nvchad-starter = import ./plugins/nvchad-starter.nix pkgs;
in {
  globals.mapleader = " ";
  globals.base46_cache = {__raw = ''vim.fn.stdpath "data" .. "/base46/"'';};

  extraConfigLuaPre = ''
    vim.opt.rtp:prepend("${nvchad-starter}")
    local lazy_config = require "configs.lazy"
  '';

  plugins = {
    lazy = {
      enable = true;
      plugins =
        [
          {
            pkg = nvchad-starter;
            lazy = false;
          }
          {
            pkg = nvchad;
            lazy = false;
          }
        ]
        ++ nvchad-init;
      config.__raw = "lazy_config";
    };
  };

  extraConfigLuaPost = ''
    dofile(vim.g.base46_cache .. "defaults")
    dofile(vim.g.base46_cache .. "statusline")

    require "options"
    require "nvchad.autocmds"

    vim.schedule(function()
      require "mappings"
    end)
  '';
}

{config, chadLib, pkgs, lib, ...}: let
  nvchad = config.chad.plugins.nvchad;
in chadLib.mkPlugin {
  inherit config;
  name= "telescope";
  pkg = pkgs.vimPlugins.telescope-nvim;

  pluginConfig = {
    dependencies = [ config.chad.plugins.treesitter.pkg ];
    cmd = "Telescope";
    opts.__raw = lib.mkIf nvchad.enable ''
      function()
        return require "nvchad.configs.telescope"
      end
    '';
  };
}

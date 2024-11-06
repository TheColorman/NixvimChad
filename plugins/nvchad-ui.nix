{config, chadLib, pkgs, lib, ...}: let
  nvchad = config.chad.plugins.nvchad;
in chadLib.mkPlugin {
  inherit config;
  name = "nvchad-ui";
  pkg = pkgs.vimPlugins.nvchad-ui;

  pluginConfig = {
    lazy = false;
    config = lib.mkIf nvchad.enable ''
      function()
        require "nvchad"
      end
    '';
  };
} 

{config, chadLib, pkgs, lib, ...}: let
  nvchad = config.chad.plugins.nvchad;
in chadLib.mkPlugin {
  inherit config;
  name = "gitsigns";
  pkg = pkgs.vimPlugins.gitsigns-nvim;

  pluginConfig = {
    event = "User FilePost";
    opts.__raw = lib.mkIf nvchad.enable ''
      function()
        return require "nvchad.configs.gitsigns"
      end
    '';
  };
}

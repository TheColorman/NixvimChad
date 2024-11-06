{config, chadLib, pkgs, lib, ...}: let
  nvchad = config.chad.plugins.nvchad;
in chadLib.mkPlugin {
  inherit config;
  name = "lspconfig";
  pkg = pkgs.vimPlugins.nvim-lspconfig;

  pluginConfig = {
    event = "User FilePost";
    config = lib.mkIf nvchad.enable ''
      function()
        require("nvchad.configs.lspconfig").defaults()
      end
    '';
  };
}

{config, chadLib, pkgs, ...}: chadLib.mkPlugin {
  inherit config;
  name = "nvchad-ui";
  pkg = pkgs.vimPlugins.nvchad-ui;

  pluginConfig = {
    lazy = false;
    config = ''
      function()
        require "nvchad"
      end
    '';
  };
} 

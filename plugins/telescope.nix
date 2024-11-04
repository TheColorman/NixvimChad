{config, chadLib, pkgs, ...}: chadLib.mkPlugin {
  inherit config;
  name= "telescope";
  pkg = pkgs.vimPlugins.telescope-nvim;

  pluginConfig = {
    dependencies = [ config.chad.plugins.treesitter.pkg ];
    cmd = "Telescope";
    opts.__raw = ''
      function()
        return require "nvchad.configs.telescope"
      end
    '';
  };
}

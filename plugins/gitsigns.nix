{config, chadLib, pkgs, ...}: chadLib.mkPlugin {
  inherit config;
  name = "gitsigns";
  pkg = pkgs.vimPlugins.gitsigns-nvim;

  pluginConfig = {
    event = "User FilePost";
    opts.__raw = ''
      function()
        return require "nvchad.configs.gitsigns"
      end
    '';
  };
}

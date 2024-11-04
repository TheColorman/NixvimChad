{chadLib, pkgs, config, ...}: chadLib.mkPlugin {
  inherit config;
  name = "nvchad";
  pkg = pkgs.vimPlugins.nvchad;

  pluginConfig.lazy = false;
}

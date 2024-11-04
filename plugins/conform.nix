{config, chadLib, pkgs, ...}: chadLib.mkPlugin {
  inherit config;
  name = "conform";
  pkg = pkgs.vimPlugins.conform-nvim;
  
  pluginConfig = {
    opts = {
      formatters_by_ft = {lua = ["stylua"];};
    };
  };
}

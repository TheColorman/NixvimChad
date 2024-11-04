{config, chadLib, pkgs, ...}: chadLib.mkPlugin {
  inherit config;
  name= "web-devicons";
  pkg = pkgs.vimPlugins.nvim-web-devicons;

  pluginConfig.opts.__raw = ''
    function()
      dofile(vim.g.base46_cache .. "devicons")
      return { override = require "nvchad.icons.devicons" }
    end
  '';
}

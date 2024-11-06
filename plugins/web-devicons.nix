{config, chadLib, pkgs, lib, ...}: let
  inherit (lib.strings) optionalString;

  nvchad = config.chad.plugins.nvchad;
in chadLib.mkPlugin {
  inherit config;
  name= "web-devicons";
  pkg = pkgs.vimPlugins.nvim-web-devicons;

  pluginConfig.opts.__raw = ''
    function()
      dofile(vim.g.base46_cache .. "devicons")
      return { ${optionalString nvchad.enable "override = require \"nvchad.icons.devicons\""} }
    end
  '';
}

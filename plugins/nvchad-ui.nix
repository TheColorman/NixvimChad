{
  config,
  chadLib,
  pkgs,
  lib,
  ...
}: let
  nvchad = config.chad.plugins.nvchad;
  nvchad-base46 = config.chad.plugins.nvchad-base46;
in
  chadLib.mkPlugin {
    inherit config;
    name = "nvchad-ui";
    pkg = pkgs.vimPlugins.nvchad-ui.overrideAttrs {
      preInstall = ''
        substituteInPlace lua/nvchad/utils.lua \
          --replace-fail '(vim.fn.stdpath "data" .. "/lazy/base46/lua/base46/themes")' '("${nvchad-base46.pkg}/lua/base46/themes")'
      '';
    };

    pluginConfig = {
      lazy = false;
      config = lib.mkIf nvchad.enable ''
        function()
          require "nvchad"
        end
      '';
    };
  }

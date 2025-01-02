{config, chadLib, pkgs, lib, ...}: let
  nvchad = config.chad.plugins.nvchad;
in chadLib.mkPlugin {
  inherit config;
  name= "nvimtree";
  pkg = pkgs.vimPlugins.nvim-tree-lua.overrideAttrs (finalAttrs: previousAttrs: {
    # Not sure what happened here
    nvimSkipModule = [ "nvim-tree._meta.api_decorator" "nvim-tree._meta.api" ];
  });

  pluginConfig = {
    cmd = ["NvimTreeToggle" "NvimTreeFocus"];
    opts.__raw = lib.mkIf nvchad.enable ''
      function()
        return require "nvchad.configs.nvimtree"
      end
    '';
  };
}

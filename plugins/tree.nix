{config, chadLib, pkgs, lib, ...}: let
  nvchad = config.chad.plugins.nvchad;
in chadLib.mkPlugin {
  inherit config;
  name= "tree";
  pkg = pkgs.vimPlugins.nvim-tree-lua;
  cmd = ["NvimTreeToggle" "NvimTreeFocus"];
  opts.__raw = lib.mkIf nvchad.enable ''
    function()
      return require "nvchad.configs.nvimtree"
    end
  '';
}

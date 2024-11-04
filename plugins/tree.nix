{config, chadLib, pkgs, ...}: chadLib.mkPlugin {
  inherit config;
  name= "tree";
  pkg = pkgs.vimPlugins.nvim-tree-lua;
  cmd = ["NvimTreeToggle" "NvimTreeFocus"];
  opts.__raw = ''
    function()
      return require "nvchad.configs.nvimtree"
    end
  '';
}

{config, chadLib, pkgs, ...}: chadLib.mkPlugin {
  inherit config;
  name= "plenary";
  pkg = pkgs.vimPlugins.plenary-nvim;
}

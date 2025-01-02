{config, chadLib, pkgs, ...}: let
  nvchad-volt = config.chad.plugins.nvchad-volt;
in
  chadLib.mkPlugin {
    inherit config;
    name = "nvchad-minty";
    pkg = pkgs.vimUtils.buildVimPlugin {
      name = "nvchad-minty";
      src = pkgs.fetchFromGitHub {
        owner = "nvzone";
        repo = "minty";
        rev = "6dce9f097667862537823d515a0250ce58faab05";
        hash = "sha256-U6IxF/i1agIGzcePYg/k388GdemBtA7igBUMwyQ3d3I=";
      };
      dependencies = [ nvchad-volt.pkg ];
    };
  
    pluginConfig = {
      cmd = [ "Huefy" "Shades" ];
    };
  }

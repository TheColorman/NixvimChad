{config, chadLib, pkgs, ...}: let
  nvchad-volt = config.chad.plugins.nvchad-volt;
  nvimtree = config.chad.plugins.nvimtree;
in
  chadLib.mkPlugin {
    inherit config;
    name = "nvchad-menu";
    pkg = pkgs.vimUtils.buildVimPlugin {
      name = "nvchad-menu";
      src = pkgs.fetchFromGitHub {
        owner = "nvzone";
        repo = "menu";
        rev = "a12605e89a5da6c63840104a95362e2bb1e9b847";
        hash = "sha256-DTAcgY0Z720AhwyQjylyXATWKCls2TlEgjpC6jwueJk=";
      };
      dependencies = [ nvchad-volt.pkg nvimtree.pkg ];
    };
  }

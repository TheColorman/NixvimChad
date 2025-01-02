{config, chadLib, pkgs, ...}: let
  nvchad-volt = config.chad.plugins.nvchad-volt;
in
  chadLib.mkPlugin {
    inherit config;
    name = "nvchad-minty";
    pkg = pkgs.vimUtils.buildVimPlugin {
      name = "nvchad-minty";
      src = pkgs.fetchFromGitHub {
        owner = "siduck";
        repo = "minty";
        rev = "1ab2b8334cec1770fef096f0a5697bf0c3afb3ca";
        hash = "sha256-91CptDILzuHFDORU6PuZuT+H09JXpQuj12eaYt1kFqI=";
      };
      dependencies = [ nvchad-volt.pkg ];
    };
  
    pluginConfig = {
      cmd = [ "Huefy" "Shades" ];
    };
  }

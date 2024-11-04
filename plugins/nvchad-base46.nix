{config,  chadLib, pkgs, ...}: chadLib.mkPlugin {
  inherit config;
  name = "nvchad-base46";
  pkg = pkgs.vimUtils.buildVimPlugin {
    name = "nvchad-base46";
    src = pkgs.fetchFromGitHub {
      owner = "nvchad";
      repo = "base46";
      rev = "v2.5";
      hash = "sha256-BaA9VEOtZA3Mw03KDrZ7yUsjcTQ+vjp4bFZuB5ax/Eo=";
    };
  };

  pluginConfig.build = ''
    function()
      require("base46").load_all_highlights()
    end
  '';
}


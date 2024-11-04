{config, chadLib, pkgs, ...}: chadLib.mkPlugin {
  inherit config;
  name = "nvchad-menu";
  pkg = pkgs.vimUtils.buildVimPlugin {
    name = "nvchad-menu";
    src = pkgs.fetchFromGitHub {
      owner = "nvchad";
      repo = "menu";
      rev = "main";
      hash = "sha256-C9ETFYyh8M6LJ5yAnYoUI+fNdhVcq8lcUb31/4eedLo=";
    };
  };
}

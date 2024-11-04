{config, chadLib, pkgs, ...}: chadLib.mkPlugin {
  inherit config;
  name = "nvchad-volt";
  pkg = pkgs.vimUtils.buildVimPlugin {
    name = "nvchad-volt";
    src = pkgs.fetchFromGitHub {
      owner = "nvchad";
      repo = "volt";
      rev = "main";
      hash = "sha256-i5gbXzJK7LpfUZbP/RG0wD0SWUj1EwUJq8Z+IEN3Ihg=";
    };
  };
}

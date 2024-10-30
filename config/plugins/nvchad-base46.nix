pkgs:
pkgs.vimUtils.buildVimPlugin {
  name = "nvchad-base46";
  src = pkgs.fetchFromGitHub {
    owner = "nvchad";
    repo = "base46";
    rev = "v2.5";
    hash = "sha256-BaA9VEOtZA3Mw03KDrZ7yUsjcTQ+vjp4bFZuB5ax/Eo=";
  };
}

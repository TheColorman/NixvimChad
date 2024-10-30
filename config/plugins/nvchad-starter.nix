pkgs:
pkgs.vimUtils.buildVimPlugin {
  name = "nvchad-starter";
  src = pkgs.fetchFromGitHub {
    owner = "nvchad";
    repo = "starter";
    rev = "main";
    hash = "sha256-SVpep7lVX0isYsUtscvgA7Ga3YXt/2jwQQCYkYadjiM=";
  };
}

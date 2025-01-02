{config, chadLib, pkgs, ...}: chadLib.mkPlugin {
  inherit config;
  name = "nvchad-volt";
  pkg = pkgs.vimUtils.buildVimPlugin {
    name = "nvchad-volt";
    src = pkgs.fetchFromGitHub {
      owner = "nvzone";
      repo = "volt";
      rev = "b7582c8e2ab3a411a72ab058251ba22d24e70f4a";
      hash = "sha256-4ui29j2+QezEReMYWHpz9OrtbdZzwz38Ov0UtJGKIxg=";
    };
  };
}

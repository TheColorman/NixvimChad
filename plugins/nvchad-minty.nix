{config, chadLib, pkgs, ...}: chadLib.mkPlugin {
  inherit config;
  name = "nvchad-minty";
  pkg = pkgs.vimUtils.buildVimPlugin {
    name = "nvchad-minty";
    src = pkgs.fetchFromGitHub {
      owner = "nvchad";
      repo = "minty";
      rev = "main";
      hash = "sha256-cthvn3CKYlA54unvz/ayS6W1/dnfhBgKOs39rzQTr2E=";
    };
  };

  pluginConfig = {
    cmd = [ "Huefy" "Shades" ];
  };
}

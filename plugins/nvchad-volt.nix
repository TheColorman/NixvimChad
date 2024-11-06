{config, chadLib, pkgs, ...}: chadLib.mkPlugin {
  inherit config;
  name = "nvchad-volt";
  pkg = pkgs.vimUtils.buildVimPlugin {
    name = "nvchad-volt";
    src = pkgs.fetchFromGitHub {
      owner = "siduck";
      repo = "volt";
      rev = "ff954757fdaf72da0dedd77bdf74718ea846f989";
      hash = "sha256-ZSlOeZ75s+IRje9U6P8riYNn8HMDImmLh7On11JXKM8=";
    };
  };
}

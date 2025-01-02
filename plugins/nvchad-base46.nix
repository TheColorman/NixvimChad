{
  config,
  chadLib,
  pkgs,
  ...
}: chadLib.mkPlugin {
  inherit config;
  name = "nvchad-base46";
  pkg = pkgs.vimUtils.buildVimPlugin {
    name = "nvchad-base46";
    src = pkgs.fetchFromGitHub {
      owner = "nvchad";
      repo = "base46";
      rev = "5009bc479de4f53ec98e9dd1692beb1f39ff3a82"; # branch v2.5
      hash = "sha256-wEDIayk6sOC3DY1t2Py3VlS11EUXqFUMVBIEVlN9CuY=";
    };
    # Disables checking lua module dependencies - this is because nvchad-ui and nvchad-base46 have a circular dependency in nixvimchad
    doCheck = false;
  };

  pluginConfig.build = ''
    function()
      require("base46").load_all_highlights()
    end
  '';
}

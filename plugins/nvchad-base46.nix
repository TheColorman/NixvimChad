{config,  chadLib, pkgs, ...}: chadLib.mkPlugin {
  inherit config;
  name = "nvchad-base46";
  pkg = pkgs.vimUtils.buildVimPlugin {
    name = "nvchad-base46";
    src = pkgs.fetchFromGitHub {
      owner = "nvchad";
      repo = "base46";
      rev = "f006ffdd0e4c0a8b1a639713f5208bc282c60058"; # branch v2.5
      hash = "sha256-jQViA0nACj+LJAIdr7SvJmFXeCiqmICPlkXuNGZAtg8=";
    };
  };

  pluginConfig.build = ''
    function()
      require("base46").load_all_highlights()
    end
  '';
}


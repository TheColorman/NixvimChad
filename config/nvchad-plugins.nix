pkgs: let
  inherit (pkgs.vimPlugins) conform-nvim nvim-lspconfig;
in [
  {
    pkg = conform-nvim;
    opts = {__raw = "require \"configs.conform\"";};
  }
  {
    pkg = nvim-lspconfig;
    config = ''
      function()
        require "configs.lspconfig"
      end
    '';
  }
]

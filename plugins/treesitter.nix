{config, chadLib, pkgs, ...}: let
  nvchad = config.chad.plugins.nvchad;
in chadLib.mkPlugin {
  inherit config;
  name= "treesitter";
  pkg = pkgs.vimPlugins.nvim-treesitter;

  pluginConfig = {
    event = [ "BufReadPost" "BufNewFile" ];
    cmd = [ "TSInstall" "TSBufEnable" "TSBufDisable" "TSModuleInfo" ];
    build = "\":TSUpdate\"";
    opts.__raw = ''
      function()
        local nvchad_treesitter_config = ${if nvchad.enable then "require \"nvchad.configs.treesitter\"" else "{}"}
        return {
          parser_install_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'site'),
          nvchad_treesitter_config,
        }
      end
    '';
    config = ''
      function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
      end
    '';
  };
}

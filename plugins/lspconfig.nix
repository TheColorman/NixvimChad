{config, chadLib, pkgs, ...}: chadLib.mkPlugin {
  inherit config;
  name = "lspconfig";
  pkg = pkgs.vimPlugins.nvim-lspconfig;

  pluginConfig = {
    event = "User FilePost";
    config = ''
      function()
        require("nvchad.configs.lspconfig").defaults()
      end
    '';
  };
}

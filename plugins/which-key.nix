{config, chadLib, pkgs, ...}: chadLib.mkPlugin {
  inherit config;
  name= "which-key";
  pkg = pkgs.vimPlugins.which-key-nvim;
  
  pluginConfig = {
    keys = ["<leader>" "<c-w>" "\"" "'" "`" "c" "v" "g"];
    cmd = "WhichKey";
    opts.__raw = ''
      function()
        dofile(vim.g.base46_cache .. "whichkey")
        return {}
      end
    '';
  };
}

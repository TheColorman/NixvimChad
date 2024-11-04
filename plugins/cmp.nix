{config, chadLib, pkgs, ...}: let
  inherit (pkgs.vimPlugins)
    nvim-cmp
    luasnip
    friendly-snippets
    nvim-autopairs
    cmp_luasnip
    cmp-nvim-lua
    cmp-nvim-lsp
    cmp-buffer
    cmp-path; 
in chadLib.mkPlugin {
  inherit config;
  name = "cmp";
  pkg = nvim-cmp;

  pluginConfig = {
    event = "InsertEnter";
    dependencies = [
      # snippet plugin
      {
        pkg = luasnip;
        dependencies = [friendly-snippets];
        opts = {
          history = true;
          updateevents = "TextChanged,TextChangedI";
        };
        config = ''
          function(_, opts)
            require("luasnip").config.set_config(opts)
            require "nvchad.configs.luasnip"
          end
        '';
      }

      # autopairing of (){}[] etc
      {
        pkg = nvim-autopairs;
        opts = {
          fast_wrap = {};
          disable_filetype = ["TelescopePrompt" "vim"];
        };
        config = ''
          function(_, opts)
            require("nvim-autopairs").setup(opts)

            -- setup cmp for autopairs
            local cmp_autopairs = require "nvim-autopairs.completion.cmp"
            require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
          end
        '';
      }

      # cmp sources plugins
      cmp_luasnip
      cmp-nvim-lua
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
    ];
    opts.__raw = ''
      function()
        return require "nvchad.configs.cmp"
      end
    '';
  };
}

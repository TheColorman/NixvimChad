pkgs: let
  inherit
    (pkgs.vimPlugins)
    plenary-nvim
    nvchad-ui
    nvim-web-devicons
    indent-blankline-nvim
    nvim-tree-lua
    which-key-nvim
    conform-nvim
    gitsigns-nvim
    nvim-lspconfig
    nvim-cmp
    luasnip
    friendly-snippets
    nvim-autopairs
    cmp_luasnip
    cmp-nvim-lua
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    telescope-nvim
    nvim-treesitter
    ;
  nvchad-base46 = import ./plugins/nvchad-base46.nix pkgs;
  nvchad-volt = import ./plugins/nvchad-volt.nix pkgs;
  nvchad-menu = import ./plugins/nvchad-menu.nix pkgs;
  nvchad-minty = import ./plugins/nvchad-minty.nix pkgs;

  _nvim-treesitter = {
    pkg = nvim-treesitter;
    event = ["BufReadPost" "BufNewFile"];
    cmd = ["TSInstall" "TSBufEnable" "TSBufDisable" "TSModuleInfo"];
    build = "\":TSUpdate\"";
    opts.__raw = ''
      function()
        local nvchad_treesitter_config = require "nvchad.configs.treesitter"
        return {
          parser_install_dir = vim.fs.joinpath(vim.fn.stdpath('data'), 'site'),
          nvchad_treesitter_config,
        }
      end
    '';
    config = ''
      function(_, opts)
        vim.opt.runtimepath:prepend(vim.fs.joinpath(vim.fn.stdpath('data'), 'site'))
        require("nvim-treesitter.configs").setup(opts)
      end
    '';
  };
in [
  plenary-nvim
  {
    pkg = nvchad-ui;
    lazy = false;
    config = ''
      function()
        require "nvchad"
      end
    '';
  }
  {
    pkg = nvchad-base46;
    build = ''
      function()
        require("base46").load_all_highlights()
      end
    '';
  }
  {
    pkg = nvchad-ui;
    lazy = false;
  }
  nvchad-volt
  nvchad-menu
  {
    pkg = nvchad-minty;
    cmd = ["Huefy" "Shades"];
  }
  {
    pkg = nvim-web-devicons;
    opts.__raw = ''
      function()
        dofile(vim.g.base46_cache .. "devicons")
        return { override = require "nvchad.icons.devicons" }
      end
    '';
  }
  {
    pkg = indent-blankline-nvim;
    event = "User FilePost";
    opts = {
      indent = {
        char = "│";
        highlight = "IblChar";
      };
      scope = {
        char = "│";
        highlight = "IblScopeChar";
      };
    };
    config = ''
      function(_, opts)
        dofile(vim.g.base46_cache .. "blankline")

        local hooks = require "ibl.hooks"
        hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
        require("ibl").setup(opts)

        dofile(vim.g.base46_cache .. "blankline")
      end
    '';
  }

  # file managing , picker etc
  {
    pkg = nvim-tree-lua;
    cmd = ["NvimTreeToggle" "NvimTreeFocus"];
    opts.__raw = ''
      function()
        return require "nvchad.configs.nvimtree"
      end
    '';
  }
  {
    pkg = which-key-nvim;
    keys = ["<leader>" "<c-w>" "\"" "'" "`" "c" "v" "g"];
    cmd = "WhichKey";
    opts.__raw = ''
      function()
        dofile(vim.g.base46_cache .. "whichkey")
        return {}
      end
    '';
  }

  # formatting!
  {
    pkg = conform-nvim;
    opts = {
      formatters_by_ft = {lua = ["stylua"];};
    };
  }

  # git stuff
  {
    pkg = gitsigns-nvim;
    event = "User FilePost";
    opts.__raw = ''
      function()
        return require "nvchad.configs.gitsigns"
      end
    '';
  }

  # >>> Mason config >>>
  # Disabled as we don't want to download plugins through mason. Kept here for
  # nvchad parity.
  # # lsp stuff
  # {
  #   pkg = mason-nvim;
  #   cmd = ["Mason" "MasonInstall" "MasonInstallAll" "MasonUpdate"];
  #   opts = {
  #     __raw = ''
  #       function()
  #         return require "nvchad.configs.mason"
  #       end
  #     '';
  #   };
  # }
  {
    pkg = nvim-lspconfig;
    event = "User FilePost";
    config = ''
      function()
        require("nvchad.configs.lspconfig").defaults()
      end
    '';
  }

  # load luasnips + cmp related in insert mode only
  {
    pkg = nvim-cmp;
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
  }
  {
    pkg = telescope-nvim;
    dependencies = [_nvim-treesitter];
    cmd = "Telescope";
    opts.__raw = ''
      function()
        return require "nvchad.configs.telescope"
      end
    '';
  }
  _nvim-treesitter
]

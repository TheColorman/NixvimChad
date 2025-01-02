# Sets the lazy config from github:nvchad/starter
{chadLib, pkgs, lib, config, ...}: let
  nvchad = config.chad.plugins.nvchad;
  nvchad-starter = pkgs.vimUtils.buildVimPlugin {
    name = "nvchad-starter";
    src = pkgs.fetchFromGitHub {
      owner = "nvchad";
      repo = "starter";
      rev = "d0c602f5f155d4d1261609219e9b8a61e936d681";
      hash = "sha256-SVpep7lVX0isYsUtscvgA7Ga3YXt/2jwQQCYkYadjiM=";
    };
    preInstall = ''
      # Delete init.lua, lua/plugins/, lua/chadrc.lua, lua/mappings.lua, and
      # lua/options.lua as they could cause issues and conflict with our own
      # versions of those files.

      rm init.lua
      rm -r lua/plugins
      rm lua/chadrc.lua
      rm lua/mappings.lua
      rm lua/options.lua
    '';
    # For some reason Nix is trying to import the modules we removed, so we need to explicitly tell it not to check them
    # Also skipping config.lspconfig, as nvchad's lspconfig relies on the global base46_cache that is only set through nixvimchad
    nvimSkipModule = [ "mappings" "chadrc" "options" "plugins" "init" "configs.lspconfig" ];
    dependencies = [ nvchad.pkg ];
  };
in chadLib.mkPlugin {
  inherit config;
  name = "nvchad-starter-lazy";
  pkg = nvchad-starter;

  extraOptions = {
    settings = let
      inherit (lib.types) either attrsOf anything str;
    in lib.mkOption {
      default = "require \"configs.lazy\"";
      example = "{ ui.wrap = false; }";
      description = "Overwrite default NvChad settings passed to lazy.nvim.";
      type = either (attrsOf anything) str;
    };
  };

  pluginConfig.lazy = false;

  globalConfig = {pkg, ...}: let
    cfg = config.chad.plugins.nvchad-starter-lazy;
    settings = cfg.settings;
    enable = cfg.enable;
  # Get inifinite recursion for some reason if I try to make the entire
  # attrset optional based on `cfg.enable`, so I have to do each 
  # individual attr??
  in {
    extraFiles = lib.attrsets.optionalAttrs enable {
      "lua/configs/lazy.lua".source = "${pkg}/lua/configs/lazy.lua";
    };
    extraConfigLuaPre = lib.strings.optionalString enable ''
      local lazy_config = ${settings}
    '';
    plugins = lib.attrsets.optionalAttrs enable {
      lazy.config.__raw = "lazy_config";
    };
  };
}

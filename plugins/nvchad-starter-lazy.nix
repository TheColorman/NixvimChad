# Sets the lazy config from github:nvchad/starter
{chadLib, pkgs, lib, config, ...}: let
  nvchad-starter = pkgs.vimUtils.buildVimPlugin {
    name = "nvchad-starter";
    src = pkgs.fetchFromGitHub {
      owner = "nvchad";
      repo = "starter";
      rev = "main";
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
    settings = config.chad.plugins.nvchad-starter-lazy.settings;
  in {
    extraFiles."lua/configs/lazy.lua".source = "${pkg}/lua/configs/lazy.lua";
    extraConfigLuaPre = ''
      local lazy_config = ${settings}
    '';
    plugins.lazy.config.__raw = "lazy_config";
  };
}

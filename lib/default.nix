{lib, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) nullOr attrsOf anything package bool;
in {
  mkPlugin = {pkg, name, config, ...}@attrs: let
    extraOptions = attrs.extraOptions or {};
  in {
    options.chad.plugins.${name} = {
      enable = mkOption {
        type = bool;
        description = ''
          Whether to enable the ${name} plugin. This plugin is usually hidden
          within NvChad, and is enabled by default. Use
          `chad.plugins.${name}.pluginConfig` to override configuration
          options.
        '';
        default = true;
      };

      pluginConfig = mkOption {
        type = nullOr (attrsOf anything);
        description = ''
          Corresponds to NixVim's `plugin.lazy.plugins.*` option, for then
          ${name} NvChad plugin. See
          https://nix-community.github.io/nixvim/plugins/lazy/plugins.html
          for an options list.
        '';
      };

      pkg = mkOption {
        type = package;
        description = "Package used by the ${name} NvChad plugin.";
        default = pkg;
      };
    } // extraOptions;

    config = let
      cfg = config.chad.plugins.${name};
      pluginConfig = {
        pkg = cfg.pkg;
      } // (attrs.pluginConfig or {});
      globalConfig = (
        if
          builtins.hasAttr "globalConfig" attrs
        then
          attrs.globalConfig {inherit pkg;}
        else {}
      );
    in ({
      plugins.lazy.plugins = lib.lists.optional cfg.enable pluginConfig;
      # Can't disable globalConfig based on cfg.enable, so rely on each plugin to do it manually. There's gotta be a better way to do this.
    } // globalConfig);
  };
}

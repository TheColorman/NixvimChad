{lib, ...}: let
  inherit (lib.types) nullOr attrsOf anything;
in {
  mkPlugin = {pkg, name, config, ...}@attrs: let
    extraOptions = attrs.extraOptions or {};
  in {
    options.chad.plugins.${name} = {
      pluginConfig = lib.mkOption {
        type = nullOr (attrsOf anything);
        description = ''
          Any config normally passed to a lazy.nvim plugin. See
          https://nix-community.github.io/nixvim/plugins/lazy/plugins.html.
        '';
      };

      pkg = lib.mkOption {
        type = lib.types.package;
        description = "Package used by the plugin.";
        default = pkg;
      };
    } // extraOptions;

    config = let
      pluginConfig = {
        pkg = config.chad.plugins.${name}.pkg;
      } // (attrs.pluginConfig or {});
      globalConfig = (
        if
          builtins.hasAttr "globalConfig" attrs
        then
          attrs.globalConfig {
            inherit pkg;
          }
        else {}
      );
    in {
      plugins.lazy.plugins = [pluginConfig];
    } // globalConfig;
  };
}

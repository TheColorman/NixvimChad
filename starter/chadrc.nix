{lib, helpers, config, pkgs, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) nullOr attrsOf anything;

  cfg = config.chad.chadrc;
  contents = ''
    local M = ${helpers.toLuaObject cfg}

    return M
  '';
  dir = pkgs.writeTextDir "lua/chadrc.lua" contents;
in {
  options.chad.chadrc = mkOption {
    type = nullOr (attrsOf anything);
    description = "Table added to chadrc.lua.";
    default = {
      base46.theme = "onedark";
    };
  };

  config.plugins.lazy.plugins = [{ pkg = dir;}];
}

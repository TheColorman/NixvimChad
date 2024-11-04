{lib, config, pkgs, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) nullOr lines;

  cfg = config.chad.options;
  contents = ''
    require "nvchad.options"

    local o = vim.o

    ${cfg}
  '';
  dir = pkgs.writeTextDir "lua/options.lua" contents;
in {
  options.chad.options = mkOption {
    type = nullOr lines;
    description = ''
      Options added to options.lua. "nvchad.options" is already imported, and `local o = vim.o` is already defined. You can also use NixVim's `opts` option.
    '';
    default = "";
  };

  config.plugins.lazy.plugins = [{ pkg = dir; }];
}

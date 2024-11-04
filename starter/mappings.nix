{lib, config, pkgs, ...}: let
  inherit (lib.options) mkOption;
  inherit (lib.types) nullOr lines;

  cfg = config.chad.mappings;
  contents = ''
    require "nvchad.mappings"

    local map = vim.keymap.set

    ${cfg}
  '';
  dir = pkgs.writeTextDir "lua/mappings.lua" contents;
in {
  options.chad.mappings = mkOption {
    type = nullOr lines;
    description = ''
      Mappings added to mappings.lua. "nvchad.mappings" is already imported. You can also use NixVim's `keymaps` option.
    '';
    default = ''
      map("n", ";", ":", { desc = "CMD enter command mode" })
      map("i", "jk", "<ESC>")
    '';
  };

  config.plugins.lazy.plugins = [{ pkg = dir; }];
}

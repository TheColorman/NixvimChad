{lib, nixvimLib, ...}: let
  inherit (lib) mkOption;
  inherit (lib.types) attrsOf listOf str anything;
  inherit (nixvimLib.helpers) mkNullOrOption;
in {
  options = {
    nixvimConfig = mkNullOrOption (attrsOf anything) "Configuration passed directly to NixVim";
    lspconfig.servers = mkNullOrOption (listOf str) "List of languages to enable language servers for.";
  };
}

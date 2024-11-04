{
  description = "An NvChad inspired NixVim configuration module";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:TheColorman/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs: let
    configure = import ./init.nix inputs;
    base = configure (_: {});
  in {
    inherit configure;
  } // base;
}

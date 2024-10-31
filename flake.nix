{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:TheColorman/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs: let
    configure = import ./configure.nix inputs;
    base = configure (_: {});
  in {
    inherit configure;
  } // base;
}

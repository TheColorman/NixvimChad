# returns a function that returns an extended NixVim config.
inputs:
mkUserConfig: 
inputs.flake-parts.lib.mkFlake {inherit inputs;} {
  systems = [
    "x86_64-linux"
    "aarch64-linux"
    "x86_64-darwin"
    "aarch64-darwin"
  ];

  perSystem = {system, pkgs, ...}@args: let
    inherit (inputs) nixvim;
    nixvim' = nixvim.legacyPackages.${system};
    chadLib = import ./lib args;
    configuration = mkUserConfig args;

    # Create base nvim package
    # NixvimChad modules extend the normal NixVim modules
    nixvimModule = {
      inherit pkgs;
      module = import ./config.nix;
      extraSpecialArgs = { inherit chadLib; };
    };
    nvimBase = nixvim'.makeNixvimWithModule nixvimModule;
    # Extend NixVim with the users extension
    nvimUserExtended = nvimBase.extend configuration;
  in {
    packages.default = nvimUserExtended;
  };
}

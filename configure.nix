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

  perSystem = {lib, system, pkgs, ...}@args: let
    inherit (inputs) nixvim;
    nixvimLib = nixvim.lib.${system};
    configuration = mkUserConfig args;

    # Evaluate our nix modules, as well as the extra provided config.
    chadModules = lib.evalModules {
      modules = [ ./modules configuration ];
      specialArgs = {inherit nixvimLib;};
    };

    # Create base nvim package
    nixvim' = nixvim.legacyPackages.${system};
    nixvimModule = {
      inherit pkgs;
      module = import ./config;
      # The NixvimChad config gets passed as an argument to the regular NixVim config
      extraSpecialArgs = {chadConfig = chadModules.config;};
    };
    nvimBase = nixvim'.makeNixvimWithModule nixvimModule;
    # Extend NixVim with the users extension
    nvimUserExtended = nvimBase.extend (configuration.nixvimConfig or {});
  in {
    packages.default = nvimUserExtended;
  };
}

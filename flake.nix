{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:TheColorman/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = {
    nixvim,
    flake-parts,
    ...
  } @ inputs: let
    withExtension = extension:
      flake-parts.lib.mkFlake {inherit inputs;} {
        systems = [
          "x86_64-linux"
          "aarch64-linux"
          "x86_64-darwin"
          "aarch64-darwin"
        ];

        perSystem = {
          pkgs,
          system,
          ...
        }: let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages.${system};
          nixvimModule = {
            inherit pkgs;
            module = import ./config;
          };
          nvim = nixvim'.makeNixvimWithModule nixvimModule;
          extended = nvim.extend extension;
        in {
          # TODO: checks here don't use the extended module.
          checks.default = nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
          packages.default = extended;
        };
      };

    noExtension = withExtension (_: {});
  in {
    inherit withExtension;
    checks = noExtension.checks;
    packages = noExtension.packages;
  };
}

args @ {
  inputs,
  withSystem,
  ...
}: {
  imports = [
    ./lib.nix
    ./pre-commit.nix
    ./treefmt.nix
    ./shell.nix
  ];

  perSystem = {system, ...}: {
    _module.args = {
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgsStable = import inputs.nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
      pkgsUnstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowunfree = true;
      };
    };
  };

  flake = let
    flakeArgs = args // {inherit withSystem;};
    importConfigs = path: import path flakeArgs;
  in {
    nixosModules.default = ./modules/nixos;
    homeModules.default = ./modules/home;
    nixosConfigurations = importConfigs ./configurations/nixos;
    homeConfigurations = importConfigs ./configurations/home;
  };
}

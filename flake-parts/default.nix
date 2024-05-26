args @ {
  inputs,
  rootPath,
  withSystem,
  ...
}: let
  flakeArgs = args // {inherit withSystem;};
  importConfigs = path: import path flakeArgs;
in {
  imports = [
    ./lib.nix
    ./pre-commit.nix
    ./treefmt.nix
    ./shell.nix
    ./packages
  ];

  perSystem = {system, ...}: {
    _module = {
      args = {
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
  };

  flake = {
    nixosModules.default = rootPath + "/modules/nixos";
    nixosConfigurations = importConfigs (rootPath + "/configurations/nixos");

    homeModules.default = rootPath + "/modules/home";
    homeConfigurations = importConfigs (rootPath + "/configurations/home");
  };
}

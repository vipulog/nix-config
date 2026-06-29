{
  inputs,
  lib,
  ...
}: {
  # other inputs may be defined at a module using them.
  flake-file.inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    import-tree.url = "github:vic/import-tree";
    den.url = "github:denful/den";
    flake-file.url = "github:vic/flake-file";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [
    inputs.flake-file.flakeModules.dendritic
    inputs.den.flakeModules.dendritic
  ];

  perSystem = {system, ...}: let
    mkAllowPredicate = names: pkg: builtins.elem (lib.getName pkg) names;
  in {
    _module.args = {
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfreePredicate = mkAllowPredicate [];
      };
    };
  };
}

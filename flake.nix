{
  description = "Vipul's nixos configuration";

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    lib = nixpkgs.lib.extend (_self: _super: {
      custom = import ./lib.nix {inherit (nixpkgs) lib;};
    });

    forAllSystems = lib.genAttrs ["x86_64-linux"];

    hostsDir = ./hosts;
    hostNames = builtins.attrNames (builtins.readDir hostsDir);

    mkHostConfig = host:
      lib.nixosSystem {
        modules = [(hostsDir + "/${host}/configuration.nix")];
        specialArgs = {inherit inputs host lib;};
      };
  in {
    nixosConfigurations = lib.genAttrs hostNames mkHostConfig;

    devShells = forAllSystems (system:
      import ./devshells {
        inherit inputs system;
        pkgs = nixpkgs.legacyPackages.${system};
        checks = self.checks.${system};
      });

    checks = forAllSystems (system:
      import ./checks {
        inherit inputs system;
        pkgs = nixpkgs.legacyPackages.${system};
        treefmt = self.formatter.${system};
      });

    formatter = forAllSystems (system:
      import ./treefmt.nix {
        inherit inputs system;
        pkgs = nixpkgs.legacyPackages.${system};
      });
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.rust-overlay.follows = "";
    };

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}

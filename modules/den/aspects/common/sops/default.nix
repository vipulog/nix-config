{inputs, ...}: {
  flake-file.inputs = {
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    my-secrets = {
      url = "github:vipulog/nix-secrets/main?shallow=1";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        import-tree.follows = "import-tree";
        git-hooks-nix.follows = "git-hooks-nix";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
  };

  den.aspects.sops-nix = {
    nixos = {
      imports = [inputs.sops-nix.nixosModules.sops];
    };

    darwin = {
      imports = [inputs.sops-nix.darwinModules.sops];
    };

    homeManager = {
      imports = [inputs.sops-nix.homeManagerModules.sops];
    };
  };
}

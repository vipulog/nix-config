{inputs, ...}: {
  flake-file.inputs = {
    nix-index = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.nix-index = let
    sharedModule = {
      programs = {
        nix-index.enable = true;
        nix-index-database.comma.enable = true;
      };
    };
  in {
    os = {
      imports = [sharedModule];
    };

    nixos = {
      imports = [inputs.nix-index.nixosModules.nix-index];
    };

    darwin = {
      imports = [inputs.nix-index.darwinModules.nix-index];
    };

    homeManager = {
      imports = [
        inputs.nix-index.homeModules.nix-index
        sharedModule
      ];
    };

    persist-user = {
      directories = {
        ".cache/nix-index".enable = true;
      };
    };
  };
}

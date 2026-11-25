{
  den,
  inputs,
  ...
}: {
  flake-file.inputs = {
    my-secrets = {
      url = "github:vipulog/nix-secrets/main";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        import-tree.follows = "import-tree";
        git-hooks-nix.follows = "git-hooks-nix";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
  };

  den.aspects.my-secrets = let
    secretsDir = "${inputs.my-secrets}/secrets/sops";

    sharedModule = {
      sops-nix = {
        inherit secretsDir;
        sharedSopsFile = "${secretsDir}/shared.yaml";
      };
    };
  in {
    includes = [den.aspects.sops-nix];

    os = {
      imports = [sharedModule];
    };

    homeManager = {
      imports = [sharedModule];
    };
  };
}

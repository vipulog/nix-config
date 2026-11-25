{inputs, ...}: {
  flake-file.inputs = {
    my-templates = {
      url = "github:vipulog/nix-templates";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        import-tree.follows = "import-tree";
        git-hooks-nix.follows = "git-hooks-nix";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
  };

  den.aspects.my-templates = let
    sharedModule = {
      nix.registry.my-templates.flake = inputs.my-templates;
    };
  in {
    os = {
      imports = [sharedModule];
    };

    homeManager = {
      imports = [sharedModule];
    };
  };
}

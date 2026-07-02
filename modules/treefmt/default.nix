{inputs, ...}: {
  imports = [inputs.treefmt-nix.flakeModule];

  flake-file.inputs = {
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  perSystem = {
    treefmt = {
      programs = {
        alejandra.enable = true;

        deadnix = {
          enable = true;
          no-lambda-pattern-names = true;
        };

        shellcheck.enable = true;
        shfmt.enable = true;
      };

      settings = {
        excludes = ["flake.nix"];
      };
    };
  };
}

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
        deadnix.enable = true;
        shellcheck.enable = true;
        shfmt.enable = true;
      };

      settings.formatter = {
        alejandra.excludes = ["flake.nix"];

        deadnix = {
          no_lambda_arg = true;
          excludes = ["flake.nix"];
        };
      };
    };
  };
}

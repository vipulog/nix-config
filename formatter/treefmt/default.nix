{self, ...}: {
  debug = true;
  perSystem = {...}: {
    treefmt = {
      projectRootFile = builtins.toString (self.lib.relativeToRoot "flake.nix");
      programs.alejandra.enable = true;
      programs.deadnix.enable = true;
      programs.shellcheck.enable = true;
      programs.shfmt.enable = true;
      settings.formatter.deadnix.no_lambda_arg = true;
    };
  };
}

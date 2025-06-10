{...}: {
  perSystem = {
    config,
    pkgs,
    ...
  }: let
    kdlinfmtExe = pkgs.lib.getExe (import ./kdlinfmt {inherit pkgs;});
  in {
    treefmt = {
      programs.alejandra.enable = true;
      programs.deadnix.enable = true;
      programs.shellcheck.enable = true;
      programs.shfmt.enable = true;
      programs.prettier.enable = true;
      programs.kdlfmt.enable = true;

      settings.formatter = {
        deadnix = {
          no_lambda_arg = true;
        };

        css-input = {
          command = config.treefmt.programs.prettier.package;
          includes = ["*.css.in"];
          options = ["--parser" "css" "--write"];
        };

        kdl-input = {
          command = kdlinfmtExe;
          includes = ["*.kdl.in"];
        };

        sh-input = {
          command = config.treefmt.programs.shfmt.package;
          includes = ["*.sh.in" "*.zsh.in"];
          options = ["--write"];
        };
      };
    };
  };
}

{
  inputs,
  pkgs,
  ...
}: let
  config = {
    projectRootFile = "./flake.nix";

    programs.alejandra.enable = true;
    programs.deadnix.enable = true;
    programs.shellcheck.enable = true;
    programs.shfmt.enable = true;

    settings.formatter.deadnix.no_lambda_arg = true;
  };
in
  (inputs.treefmt-nix.lib.evalModule pkgs config)
  .config
  .build
  .wrapper

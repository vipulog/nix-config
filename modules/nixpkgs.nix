{
  lib,
  inputs,
  ...
}: {
  perSystem = {system, ...}: let
    mkAllowPredicate = names: pkg: builtins.elem (lib.getName pkg) names;
  in {
    _module.args = {
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfreePredicate = mkAllowPredicate ["replace"];
      };
    };
  };
}

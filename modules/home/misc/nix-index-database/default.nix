{
  lib,
  config,
  inputs,
  namespace,
  ...
}: let
  cfg = config.${namespace}.misc.nix-index-database;
in {
  options.${namespace}.misc.nix-index-database = {
    enable = lib.mkEnableOption "nix-index-database";
  };

  imports = [
    inputs.nix-index-database.homeModules.nix-index
  ];

  config = lib.mkMerge [
    (lib.mkDefault {programs.nix-index.enable = false;})

    (lib.mkIf cfg.enable {
      programs = {
        nix-index.enable = true;
        nix-index-database.comma.enable = true;
      };
    })
  ];
}

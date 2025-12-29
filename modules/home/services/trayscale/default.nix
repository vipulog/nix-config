{
  pkgs,
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.services.trayscale;
in {
  options.${namespace}.services.trayscale = {
    enable = lib.mkEnableOption "trayscale";
  };

  config = let
    pkg = pkgs.trayscale;
  in
    lib.mkIf cfg.enable {
      home.packages = [pkg];

      services.trayscale = {
        enable = true;
        package = pkg;
      };
    };
}

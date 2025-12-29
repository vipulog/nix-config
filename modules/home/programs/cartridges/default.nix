{
  pkgs,
  config,
  lib,
  namespace,
  ...
}: let
  cfg = config.${namespace}.programs.cartridges;
in {
  options.${namespace}.programs.cartridges = {
    enable = lib.mkEnableOption "cartridges";
  };

  config = lib.mkIf cfg.enable {
    home.packages = [pkgs.cartridges];

    dconf = {
      enable = true;

      settings = {
        "page/kramo/Cartridges" = {
          auto-import = true;
          cover-launches-game = false;
          desktop = true;
          exit-after-launch = false;
          high-quality-images = true;
          remove-missing = true;
          sgdb = true;
          sgdb-animated = true;
          sgdb-prefer = true;
        };
      };
    };
  };
}

{
  config,
  lib,
  namespace,
  ...
}: let
  cfg = config.${namespace}.programs.ghostty;
in {
  options.${namespace}.programs.ghostty = {
    enable = lib.mkEnableOption "ghostty";

    theme = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "The theme to use for ghostty.";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;

      settings = lib.mkMerge [
        {
          window-padding-balance = true;
          window-padding-x = 3;
          window-padding-y = 3;
          window-padding-color = "background";
        }
        (lib.optionalAttrs (cfg.theme != null) {
          inherit (cfg) theme;
        })
      ];
    };
  };
}

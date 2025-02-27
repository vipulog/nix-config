{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.services.dm;
in {
  options.internal.services.dm = {
    enable = mkEnableOption "dm";

    autoLogin = {
      enable = mkEnableOption "auto login";

      user = mkOption {
        type = types.str;
        description = "The username to auto-login as.";
      };
    };
  };

  config = mkIf cfg.enable {
    services.displayManager = {
      enable = true;
      ly.enable = true;
      autoLogin = mkIf cfg.autoLogin.enable {
        enable = true;
        user = cfg.autoLogin.user;
      };
    };
  };
}

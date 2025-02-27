{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.system.locale;
in {
  options.internal.system.locale = with types; {
    enable = mkEnableOption "locale configuration";
  };

  config = mkIf cfg.enable {
    i18n.defaultLocale = "en_US.UTF-8";

    console = {
      keyMap = mkForce "us";
    };
  };
}

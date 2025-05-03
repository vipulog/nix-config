{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.services.mako;
in {
  options.internal.services.mako = with types; {
    enable = mkEnableOption "mako";
  };

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
    };
  };
}

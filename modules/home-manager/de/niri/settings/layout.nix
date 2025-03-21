{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.de.niri;
in {
  config = mkIf cfg.enable {
    programs.niri.settings.layout = {
      gaps = 8;
    };
  };
}

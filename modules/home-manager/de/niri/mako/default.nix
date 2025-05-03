{
  config,
  lib,
  ...
}:
with lib; let
  niriCfg = config.internal.de.niri;
in {
  config = mkIf niriCfg.enable {
    services.mako = {
      enable = true;
    };
  };
}

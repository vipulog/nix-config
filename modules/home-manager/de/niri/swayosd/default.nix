{
  lib,
  config,
  ...
}:
with lib; let
  niriCfg = config.internal.de.niri;
in {
  config = mkIf niriCfg.enable {
    services.swayosd.enable = true;
    home.file.".config/swayosd/style.css".text = builtins.readFile ./style.css;
  };
}

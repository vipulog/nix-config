{
  lib,
  config,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  config = mkIf senkaiCfg.enable {
    services.swayosd.enable = true;
    home.file.".config/swayosd/style.css".text = builtins.readFile ./style.css;
  };
}

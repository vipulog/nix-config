{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.services.swayosd;
in {
  options.internal.services.swayosd = {
    enable = mkEnableOption "swayosd";
  };

  config = mkIf cfg.enable {
    services.swayosd.enable = true;
    home.file.".config/swayosd/style.css".text = builtins.readFile ./style.css;
  };
}

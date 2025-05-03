{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.de.niri;
in {
  imports = [
    ./options.nix
    ./settings
  ];

  config = mkIf cfg.enable {
    internal = {
      misc.stylix.enable = true;
      services.swayosd.enable = true;
      services.mako.enable = true;
    };
  };
}

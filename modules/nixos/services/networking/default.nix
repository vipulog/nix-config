{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.services.networking;
in {
  options.internal.services.networking = {
    enable = mkEnableOption "networking";
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
  };
}

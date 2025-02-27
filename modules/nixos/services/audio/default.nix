{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.internal.services.audio;
in {
  options.internal.services.audio = {
    enable = mkEnableOption "audio";
  };

  config = mkIf cfg.enable {
    services.pipewire.enable = true;
    security.rtkit.enable = true;
    environment.systemPackages = [pkgs.playerctl];
  };
}

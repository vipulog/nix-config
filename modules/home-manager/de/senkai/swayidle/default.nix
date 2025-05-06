{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  config = mkIf senkaiCfg.enable {
    services.swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 80;
          command = "${getExe pkgs.niri} msg action power-off-monitors";
          resumeCommand = "${getExe pkgs.niri} msg action power-on-monitors";
        }
        {
          timeout = 300;
          command = "systemctl suspend";
        }
      ];
    };
  };
}

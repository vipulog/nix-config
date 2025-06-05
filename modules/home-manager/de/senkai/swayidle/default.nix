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
          timeout = 60;
          command = "${lib.getExe' pkgs.swaylock-effects "swaylock"} -fF --grace 10 --fade-in 4";
        }
        {
          timeout = 65;
          command = "${lib.getExe pkgs.niri} msg action power-off-monitors";
          resumeCommand = "${lib.getExe pkgs.niri} msg action power-on-monitors";
        }
        {
          timeout = 80;
          command = "${lib.getExe' pkgs.systemd "systemctl"} suspend";
        }
      ];
      events = [
        {
          event = "before-sleep";
          command = "${lib.getExe' pkgs.swaylock-effects "swaylock"} -fF";
        }
      ];
    };
  };
}

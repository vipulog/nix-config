{
  lib,
  config,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.internal.de.niri;
in {
  config = mkIf cfg.enable {
    programs.niri.settings.spawn-at-startup = [
      {command = ["${getExe pkgs.xwayland-satellite}"];}
      {command = ["${getExe pkgs.clipse}" "-listen"];}
      {command = ["${getExe inputs.vgs.packages.${pkgs.system}.default}"];}
      {
        command = [
          "sh"
          "-c"
          ''
            ${getExe' pkgs.swww "swww-daemon"} & \
            sleep 1 && \
            ${getExe pkgs.swww} img ${self.lib.relativeToRoot "assets/wallpapers/wallpaper.jpg"}
          ''
        ];
      }
    ];
  };
}

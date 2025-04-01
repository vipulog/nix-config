{
  lib,
  config,
  pkgs,
  inputs',
  self,
  ...
}:
with lib; let
  cfg = config.internal.de.niri;
in {
  config = mkIf cfg.enable {
    programs.niri.settings.spawn-at-startup = [
      {command = ["${getExe pkgs.xwayland-satellite}"];}
      {command = ["${getExe pkgs.clipse}" "-listen"];}
      {command = ["${getExe inputs'.vgs.packages.default}"];}
      {command = ["${getExe pkgs.swaybg}" "-i" "${self.lib.relativeToRoot "assets/wallpapers/wallpaper.jpg"}"];}
    ];
  };
}

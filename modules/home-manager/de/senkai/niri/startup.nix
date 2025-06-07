{
  lib,
  config,
  pkgs,
  self,
  inputs',
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  config = mkIf senkaiCfg.enable {
    programs.niri.settings.spawn-at-startup =
      [
        {command = ["${getExe pkgs.xwayland-satellite}"];}
        {command = ["${getExe' pkgs.swayosd "swayosd-server"}"];}
        {command = ["${getExe pkgs.swaybg}" "-i" "${self.lib.relativeToRoot "assets/wallpapers/wallpaper.jpg"}"];}

        # https://github.com/sodiboo/niri-flake/issues/509
        {command = ["systemctl" "--user" "restart" "xdg-desktop-portal-gnome"];}
        {command = ["systemctl" "--user" "restart" "clipse"];}
      ]
      ++ lib.optionals config.internal.programs.ghostty.enable [
        {command = ["${getExe pkgs.ghostty}"];}
      ]
      ++ lib.optionals config.internal.programs.zen-browser.enable [
        {command = ["${getExe inputs'.zen-browser.packages.default}"];}
      ]
      ++ lib.optionals config.internal.programs.whatsapp-web.enable [
        {command = splitString " " "${config.xdg.desktopEntries.whatsapp-web.exec}";}
      ]
      ++ lib.optionals config.internal.programs.btop.enable [
        {command = ["${getExe pkgs.ghostty}" "--command=${getExe pkgs.btop}" "--title=btop"];}
      ];
  };
}

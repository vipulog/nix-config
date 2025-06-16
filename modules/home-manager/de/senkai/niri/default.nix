{
  lib,
  pkgs,
  self,
  config,
  inputs',
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
  stylixColors = config.lib.stylix.colors.withHashtag;

  vars = {
    ACTIVE_BORDER_COLOR = stylixColors.base0D;
    INACTIVE_BORDER_COLOR = stylixColors.base03;
    CLIPSE_EXE = getExe' pkgs.clipse "clipse";
    CURSOR_NAME = config.stylix.cursor.name;
    CURSOR_SIZE = config.stylix.cursor.size;
    FLOCK_EXE = getExe' pkgs.util-linux "flock";
    GHOSTTY_EXE = getExe' pkgs.ghostty "ghostty";
    SWAYOSD_CLIENT_EXE = getExe' pkgs.swayosd "swayosd-client";
    SWAYBG_EXE = getExe' pkgs.swaybg "swaybg";
    WALLPAPER = self.lib.relativeToRoot "assets/wallpapers/wallpaper.jpg";
    WOFI_EXE = getExe' pkgs.wofi "wofi";
    XWAYLAND_SATELLITE_EXE = getExe' pkgs.xwayland-satellite "xwayland-satellite";
  };

  startupCommands = flatten (
    lib.optionals config.internal.programs.ghostty.enable [
      "spawn-at-startup \"${vars.GHOSTTY_EXE}\""
    ]
    ++ lib.optionals config.internal.programs.zen-browser.enable [
      "spawn-at-startup \"${getExe inputs'.zen-browser.packages.default}\""
    ]
    ++ lib.optionals config.internal.programs.whatsapp-web.enable [
      "spawn-at-startup \"${config.xdg.desktopEntries.whatsapp-web.exec}\""
    ]
    ++ lib.optionals config.internal.programs.btop.enable [
      "spawn-at-startup \"${vars.GHOSTTY_EXE}\" \"--command=${getExe pkgs.btop}\" \"--title=btop\""
    ]
  );
in {
  config = mkIf senkaiCfg.enable {
    programs.niri.config = pipe ./config.kdl.in [
      (path: pkgs.replaceVars path vars)
      readFile
      (base: base + concatLines startupCommands)
      (full: replaceStrings ["\"__UNQUOTE__" "__UNQUOTE__\""] ["" ""] full)
    ];
  };
}

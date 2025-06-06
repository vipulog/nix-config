{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.internal.programs.whatsapp-web;
in {
  options.internal.programs.whatsapp-web = {
    enable = mkEnableOption "whatsapp-web";
  };
  config = mkIf cfg.enable {
    xdg.desktopEntries = {
      whatsapp-web = {
        name = "WhatsApp Web";
        exec = "${lib.getExe' pkgs.ungoogled-chromium "chromium"} --app=https://web.whatsapp.com";
        icon = "${./whatsapp-icon.svg}";
        type = "Application";
        categories = ["Network" "InstantMessaging"];
      };
    };
  };
}

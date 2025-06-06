{
  lib,
  config,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  config = mkIf senkaiCfg.enable {
    programs.niri.settings.window-rules = [
      {
        open-maximized = true;
        open-on-workspace = "scratch";
        clip-to-geometry = true;
        geometry-corner-radius = {
          top-left = 0.0;
          top-right = 0.0;
          bottom-left = 0.0;
          bottom-right = 0.0;
        };
      }

      {
        matches = [{app-id = "com.mitchellh.ghostty";}];
        open-on-workspace = "code";
      }

      {
        matches = [{app-id = "^zen";}];
        open-on-workspace = "web";
      }

      {
        matches = [{app-id = "^chrome-web.whatsapp.com";}];
        open-on-workspace = "chat";
      }

      {
        matches = [{title = "btop";}];
        open-on-workspace = "system-monitor";
      }
    ];
  };
}

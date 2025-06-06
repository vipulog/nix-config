{
  lib,
  config,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  config = mkIf senkaiCfg.enable {
    programs.niri.settings.workspaces = {
      "01-code" = {name = "code";};
      "02-web" = {name = "web";};
      "03-chat" = {name = "chat";};
      "04-scratch" = {name = "scratch";};
      "05-system-monitor" = {name = "system-monitor";};
    };
  };
}

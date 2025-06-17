{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.internal.programs.whatsapp-web;
  whatsappWebBin = pkgs.writeShellScriptBin "whatsapp-web.sh" ''
    ${lib.getExe' pkgs.ungoogled-chromium "chromium"} --app=https://web.whatsapp.com
  '';
  whatsappWebExe = lib.getExe whatsappWebBin;
in {
  options.internal.programs.whatsapp-web = {
    enable = mkEnableOption "whatsapp-web";
    exe = mkOption {
      type = types.str;
      default = whatsappWebExe;
      readOnly = true;
    };
  };
  config = mkIf cfg.enable {
    xdg.desktopEntries = {
      whatsapp-web = {
        name = "WhatsApp Web";
        exec = whatsappWebExe;
        icon = "${./whatsapp-icon.svg}";
        type = "Application";
        categories = ["Network" "InstantMessaging"];
      };
    };
  };
}

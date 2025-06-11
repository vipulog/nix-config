{
  pkgs,
  lib,
  config,
  osConfig,
  inputs',
  ...
}:
with lib; let
  cfg = config.internal.programs.zellij;
in {
  options.internal.programs.zellij = {
    enable = mkEnableOption "zellij";
  };

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
    };

    xdg.configFile."zellij/config.kdl".text = readFile ./config.kdl;

    xdg.configFile."zellij/layouts/default.kdl".text = readFile (
      pkgs.replaceVars ./layouts/default.kdl.in (with config.lib.stylix.colors.withHashtag; {
        ZJSTATUS_PLUGIN_LOCATION = "file://${inputs'.zjstatus.packages.default}/bin/zjstatus.wasm";
        TIMEZONE = osConfig.time.timeZone;
        COLOR_BASE01 = base01;
        COLOR_BASE02 = base02;
        COLOR_BASE03 = base03;
        COLOR_BASE04 = base04;
        COLOR_BASE05 = base05;
        COLOR_BASE06 = base06;
        COLOR_BASE08 = base08;
        COLOR_BASE09 = base09;
        COLOR_BASE0A = base0A;
        COLOR_BASE0B = base0B;
        COLOR_BASE0C = base0C;
        COLOR_BASE0D = base0D;
        COLOR_BASE0E = base0E;
        COLOR_BASE0F = base0F;
      })
    );
  };
}

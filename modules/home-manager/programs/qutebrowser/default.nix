{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.programs.qutebrowser;
in {
  options.internal.programs.qutebrowser = {
    enable = mkEnableOption "qutebrowser";
  };

  config = mkIf cfg.enable {
    programs.qutebrowser = {
      enable = true;
      settings = {
        tabs.tabs_are_windows = true;
        colors.webpage.preferred_color_scheme = "dark";
      };
    };
  };
}

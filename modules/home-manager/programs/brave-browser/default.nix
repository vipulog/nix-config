{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.programs.brave-browser;
in {
  options.internal.programs.brave-browser = {
    enable = mkEnableOption "brave-browser";
  };

  config = mkIf cfg.enable {
    programs.brave = {
      enable = true;
      commandLineArgs = [
        "--no-default-browser-check"
        "--restore-last-session"
      ];
    };
  };
}

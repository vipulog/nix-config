{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.internal.home.vipul;
in {
  options.internal.home.vipul = {
    enable = mkEnableOption "user-specific home configurations for vipul";
  };

  config = mkIf cfg.enable {
    home = {
      username = "vipul";
      homeDirectory = "/home/vipul";

      sessionVariables = {
        VISUAL = "nvim";
        EDITOR = "nvim";
      };

      packages = with pkgs; [
        coreutils # basic gnu utils
      ];
    };

    internal = {
      profiles = {
        common.enable = true;
        development.enable = true;
        graphical.enable = true;
      };

      programs = {
        zen-browser.enable = true;
        android-studio.enable = true;
      };

      services = {
        redirector.enable = true;
      };
    };
  };
}

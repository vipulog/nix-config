{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.internal.programs.zen-browser;
in {
  options.internal.programs.zen-browser = {
    enable = mkEnableOption "zen-browser";
  };

  config = mkIf cfg.enable {
    home.packages = [
      inputs.zen-browser.packages.${pkgs.system}.default
    ];
  };
}

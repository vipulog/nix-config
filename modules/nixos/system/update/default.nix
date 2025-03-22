{
  self,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.system.autoUpdate;
in {
  options.internal.system.autoUpdate = {
    enable = mkEnableOption "auto updates";
  };

  config = mkIf cfg.enable {
    system.autoUpgrade = {
      enable = true;
      flake = self.outPath;
      dates = "daily";
      randomizedDelaySec = "45min";
      operation = "boot";
      flags = [
        "--update-input"
        "nixpkgs"
        "-L" # print build logs
      ];
    };
  };
}

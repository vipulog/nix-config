{
  config,
  lib,
  host,
  ...
}:
with lib; let
  cfg = config.internal.system.autoUpdate;
  input = "github:vipulog/nixos-config?ref=main";
in {
  options.internal.system.autoUpdate = {
    enable = mkEnableOption "auto updates";
  };

  config = mkIf cfg.enable {
    system.autoUpgrade = {
      enable = true;
      flake = "${input}#${host}";
      dates = "weekly";
      randomizedDelaySec = "45min";
      operation = "boot";
      flags = [
        "-L" # print build logs
      ];
    };
  };
}

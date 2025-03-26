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
      dates = "daily";
      randomizedDelaySec = "45min";
      operation = "boot";
      flags = [
        "--refresh"
        "-L" # print build logs
      ];
    };
  };
}

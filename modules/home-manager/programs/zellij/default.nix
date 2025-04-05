{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.programs.zellij;
in {
  imports = [
    ./config.nix
    ./sesh.nix
  ];

  options.internal.programs.zellij = {
    enable = mkEnableOption "zellij";
  };

  config = mkIf cfg.enable {
    programs.zellij = {
      enable = true;
    };
  };
}

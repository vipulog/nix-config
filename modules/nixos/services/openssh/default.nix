{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.services.openssh;
in {
  options.internal.services.openssh = with types; {
    enable = mkEnableOption "OpenSSH";
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = true;
    };
  };
}

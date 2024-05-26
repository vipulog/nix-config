{
  config,
  namespace,
  lib,
  ...
}: let
  cfg = config.${namespace}.system.audio;
in {
  options.${namespace}.system.audio = {
    enable = lib.mkEnableOption "audio";
  };

  config = lib.mkIf cfg.enable {
    services.pipewire.enable = true;
    security.rtkit.enable = true;
  };
}

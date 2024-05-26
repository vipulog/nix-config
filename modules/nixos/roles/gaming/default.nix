{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.roles.gaming;
in {
  options.${namespace}.roles.gaming = {
    enable = lib.mkEnableOption "gaming role";
  };

  config = lib.mkIf cfg.enable {
    ${namespace} = {
      system.graphics.enable = true;
      programs.steam.enable = true;
    };
  };
}

{
  config,
  namespace,
  lib,
  ...
}: let
  cfg = config.${namespace}.programs.ssh;
in {
  options.${namespace}.programs.ssh = {
    enable = lib.mkEnableOption "ssh";
  };

  config = lib.mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          addKeysToAgent = "yes";
          forwardAgent = true;
        };
      };
    };
  };
}

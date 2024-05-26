{
  config,
  lib,
  namespace,
  ...
}: let
  cfg = config.${namespace}.programs.home-manager;
in {
  options.${namespace}.programs.home-manager = {
    enable = lib.mkEnableOption "home-manager";
  };

  config = lib.mkIf cfg.enable {
    news.display = "silent";
    programs.home-manager.enable = true;
  };
}

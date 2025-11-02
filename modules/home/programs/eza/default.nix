{
  config,
  lib,
  namespace,
  ...
}: let
  cfg = config.${namespace}.programs.eza;
in {
  options.${namespace}.programs.eza = {
    enable = lib.mkEnableOption "eza";
  };

  config = lib.mkIf cfg.enable {
    programs.eza = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      icons = "auto";
    };
  };
}

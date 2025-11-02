{
  config,
  lib,
  namespace,
  ...
}: let
  cfg = config.${namespace}.programs.delta;
  gitEnabled = config.${namespace}.programs.git.enable;
in {
  options.${namespace}.programs.delta = {
    enable = lib.mkEnableOption "delta";
  };

  config = lib.mkIf cfg.enable {
    programs.delta = {
      enable = true;
      enableGitIntegration = lib.mkIf gitEnabled true;
      options = {
        diff-so-fancy = true;
        line-numbers = true;
        true-color = "always";
      };
    };
  };
}

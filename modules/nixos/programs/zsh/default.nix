{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.programs.zsh;
in {
  options.internal.programs.zsh = {
    enable = mkEnableOption "zsh";

    enableCompletion = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable zsh completion.";
    };
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = cfg.enableCompletion;
    };
  };
}

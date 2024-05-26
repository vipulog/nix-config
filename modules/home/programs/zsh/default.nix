{
  config,
  namespace,
  lib,
  ...
}: let
  cfg = config.${namespace}.programs.zsh;
in {
  options.${namespace}.programs.zsh = {
    enable = lib.mkEnableOption "zsh";
  };

  config = lib.mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}

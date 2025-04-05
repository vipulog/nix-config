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
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;

      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      initExtra =
        #shell
        ''
          # Add a newline between commands
          precmd() { precmd() { echo "" } }
          alias clear="precmd() { precmd() { echo } } && clear"
        '';
    };
  };
}

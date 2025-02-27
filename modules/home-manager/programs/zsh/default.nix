{
  config,
  lib,
  pkgs,
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
          if [[ -z "$STARSHIP_SESSION_KEY" ]]; then
            FORTUNE=$(${lib.getExe pkgs.fortune} -s)
            BOX_CMD=${lib.getExe pkgs.boxes}

            echo "$FORTUNE" | "$BOX_CMD" -d c
          fi

          # Add a newline between commands
          precmd() { precmd() { echo "" } }
          alias clear="precmd() { precmd() { echo } } && clear"
        '';
    };
  };
}

{
  pkgs,
  lib,
  ...
}: {
  programs.zsh = {
    enable = true;

    initExtra =
      #shell
      ''
        if [[ -z "$STARSHIP_SESSION_KEY" ]]; then
          FORTUNE=$(${lib.getExe pkgs.fortune} -s)
          BOX_CMD=${lib.getExe pkgs.boxes}

          echo "$FORTUNE" | "$BOX_CMD" -d c
        fi

        # Add a newline between commands
        # https://github.com/starship/starship/issues/560
        precmd() { precmd() { echo "" } }
        alias clear="precmd() { precmd() { echo } } && clear"
      '';
  };
}

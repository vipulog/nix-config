{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.programs.zellij;

  sesh = pkgs.writeScriptBin "sesh" ''
    #! /usr/bin/env sh

    # Taken from https://github.com/zellij-org/zellij/issues/884#issuecomment-1851136980
    # select a directory using zoxide
    ZOXIDE_RESULT=$(${lib.getExe pkgs.zoxide} query --interactive)

    # checks whether a directory has been selected
    if [[ -z "$ZOXIDE_RESULT" ]]; then
    	# if there was no directory, select returns without executing
    	exit 0
    fi

    # extracts the directory name from the absolute path
    SESSION_TITLE=$(echo "$ZOXIDE_RESULT" | ${lib.getExe pkgs.gnused} 's#.*/##')

    # get the list of sessions
    SESSION_LIST=$(${lib.getExe pkgs.zellij} list-sessions -n | ${lib.getExe pkgs.gawk} '{print $1}')

    # checks if SESSION_TITLE is in the session list
    if echo "$SESSION_LIST" | ${lib.getExe pkgs.gnugrep} -q "^$SESSION_TITLE$"; then
    	# if so, attach to existing session
    	${lib.getExe pkgs.zellij} attach "$SESSION_TITLE"
    else
    	# if not, create a new session
    	echo "Creating new session $SESSION_TITLE and CD $ZOXIDE_RESULT"
    	cd $ZOXIDE_RESULT
    	${lib.getExe pkgs.zellij} attach -c "$SESSION_TITLE"
    fi
  '';
in {
  config = mkIf cfg.enable {
    home.packages = [
      sesh
    ];
  };
}

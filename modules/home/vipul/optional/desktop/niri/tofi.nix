{
  pkgs,
  lib,
  config,
  ...
}: {
  home.activation = {
    # https://github.com/philj56/tofi/issues/115#issuecomment-1701748297
    regenerateTofiCache = lib.hm.dag.entryAfter ["writeBoundary"] ''
      tofi_cache=${config.xdg.cacheHome}/tofi-drun
      [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
    '';
  };

  programs.tofi = {
    enable = true;

    settings = {
      hint-font = false;
      ascii-input = true;
      late-keyboard-init = true;
      terminal = "${lib.getExe pkgs.ghostty} -e";
      anchor = "bottom";
      width = "100%";
      height = 36;
      horizontal = true;
      prompt-text = " run: ";
      outline-width = 0;
      border-width = 2;
      min-input-width = 20;
      result-spacing = 20;
      padding-top = 4;
      padding-bottom = 4;
      padding-left = 4;
      padding-right = 4;
    };
  };
}

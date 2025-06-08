{
  pkgs,
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

      plugins = [
        {
          name = "vi-mode";
          src = pkgs.zsh-vi-mode;
          file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
        }
      ];

      initContent = concatStringsSep "\n" [
        (readFile ./init-scripts/prompt.zsh)
      ];
    };
  };
}

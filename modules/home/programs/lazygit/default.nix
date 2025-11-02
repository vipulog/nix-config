{
  config,
  lib,
  pkgs,
  namespace,
  ...
}: let
  cfg = config.${namespace}.programs.lazygit;
in {
  options.${namespace}.programs.lazygit = {
    enable = lib.mkEnableOption "lazygit";
  };

  config = lib.mkIf cfg.enable {
    programs.lazygit = {
      enable = true;

      settings = {
        git.paging.pager = "${pkgs.delta}/bin/delta --dark --paging=never";

        gui = {
          expandFocusedSidePanel = true;
          nerdFontsVersion = "3";
          showDivergenceFromBaseBranch = "arrowAndNumber";
          statusPanelView = "allBranchesLog";
        };
      };
    };
  };
}

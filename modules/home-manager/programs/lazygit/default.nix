{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.internal.programs.lazygit;
in {
  options.internal.programs.lazygit = {
    enable = mkEnableOption "lazygit";
  };

  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;

      settings = {
        gui = {
          expandFocusedSidePanel = true;
          sidePanelWidth = 0.4;
          showRandomTip = false;
          showBottomLine = false;
          nerdFontsVersion = "3";
          showDivergenceFromBaseBranch = "arrowAndNumber";
          border = "single";
          statusPanelView = "allBranchesLog";
        };

        git = {
          paging = {
            pager = "${getExe pkgs.delta} --dark --paging=never";
          };
        };
      };
    };
  };
}

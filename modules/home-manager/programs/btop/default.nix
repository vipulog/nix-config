{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.programs.btop;
in {
  options.internal.programs.btop = {
    enable = mkEnableOption "btop";
  };

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;

      settings = {
        vim_keys = true;
        theme_backgroud = false;
        rounded_corners = false;
        shown_boxes = "proc cpu gpu0 mem net";
        proc_tree = true;
        clock_format = "/user@/host %X - %A, %d %B %Y";
      };
    };
  };
}

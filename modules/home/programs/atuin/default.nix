{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.programs.atuin;
in {
  options.${namespace}.programs.atuin = {
    enable = lib.mkEnableOption "atuin";
  };

  config = lib.mkIf cfg.enable {
    programs.atuin = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      daemon.enable = true;

      settings = {
        update_check = false;
        sync_frequency = "1m";
        workspaces = true;
        style = "auto";
        show_help = false;
        exit_mode = "return-query";
        command_chaining = true;
        enter_accept = true;
        prefers_reduced_motion = true;
        sync.records = true;
        keymap_mode = "vim-insert";

        keymap_cursor = {
          vim_normal = "steady-block";
          vim_insert = "blink-bar";
        };
      };
    };
  };
}

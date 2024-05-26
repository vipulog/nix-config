{
  lib,
  config,
  inputs,
  namespace,
  ...
}: let
  cfg = config.${namespace}.programs.atuin;
  sopsEnabled = config.${namespace}.misc.sops.enable;
in {
  options.${namespace}.programs.atuin = {
    enable = lib.mkEnableOption "atuin";
  };

  config = lib.mkIf cfg.enable (lib.mkMerge [
    {
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
          keymap_mode = "vim-insert";
          keymap_cursor = {
            vim_normal = "steady-block";
            vim_insert = "blink-bar";
          };
          prefers_reduced_motion = true;
          sync.records = true;
        };
      };
    }

    (lib.mkIf sopsEnabled (let
      sopsFolder = (builtins.toString inputs.nix-secrets) + "/secrets/sops";
    in {
      sops.secrets."keys/atuin" = {
        path = "${config.home.homeDirectory}/.local/share/atuin/key";
        sopsFile = "${sopsFolder}/shared.yaml";
      };
    }))
  ]);
}

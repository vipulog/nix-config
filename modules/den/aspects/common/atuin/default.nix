{
  inputs,
  den,
  ...
}: {
  den.aspects.atuin = {
    host,
    user ? null,
    ...
  }: {
    nixos = {lib, ...}: let
      isEphemeralHost = host.hasAspect den.aspects.ephemeral-host;
    in {
      config = lib.mkMerge [
        (lib.mkIf isEphemeralHost {
          preservation.preserve = {
            users = lib.mkIf (user != null) {
              ${user.name}.directories = [
                {
                  directory = ".local/share/atuin";
                  mode = "0700";
                }
              ];
            };
          };
        })
      ];
    };

    homeManager = {
      pkgs,
      lib,
      config,
      ...
    }: let
      hasSops = user.hasAspect den.aspects.sops-nix;
    in {
      config = lib.mkMerge [
        {
          programs.atuin = {
            enable = true;
            daemon.enable = true;

            settings = {
              auto_sync = true;
              update_check = false;
              sync_address = "https://api.atuin.sh";
              sync_frequency = "1m";
              search_mode = "daemon-fuzzy";
              search_mode_shell_up_key_binding = "daemon-fuzzy";
              filter_mode = "workspace";
              filter_mode_shell_up_key_binding = "global";
              workspaces = true;
              style = "compact";
              inline_height = 26;
              show_preview = false;
              show_help = false;
              show_tabs = false;
              exit_mode = "return-original";
              history_format = "{time} {user}@{host}\\n{directory}\\n> {command} [{duration}]\\n";
              secrets_filter = true;
              show_numeric_shortcuts = false;
              command_chaining = true;
              enter_accept = true;
              keymap_mode = "auto";

              stats.common_prefix = ["sudo" ","];
              sync.records = true;
              ui.columns = ["time" "command"];
              daemon.autostart = true;
            };
          };
        }

        (lib.mkIf hasSops {
          sops.secrets = {
            atuin-key.sopsFile = "${inputs.my-secrets}/secrets/sops/shared.yaml";
            atuin-username.sopsFile = "${inputs.my-secrets}/secrets/sops/shared.yaml";
            atuin-password.sopsFile = "${inputs.my-secrets}/secrets/sops/shared.yaml";
          };

          programs.atuin.settings = {
            key_path = config.sops.secrets.atuin-key.path;
          };

          systemd.user.services.atuin-login = {
            Unit = {
              Description = "Atuin login";
              After = ["sops-nix.service"];
              ConditionPathExists = "!%h/.local/share/atuin/meta.db";
            };

            Service = {
              Type = "simple";
              ExecStart = pkgs.writeShellScript "atuin-login" ''
                USERNAME=$(cat ${config.sops.secrets.atuin-username.path})
                PASSWORD=$(cat ${config.sops.secrets.atuin-password.path})
                ${lib.getExe pkgs.atuin} login --username "$USERNAME" --password "$PASSWORD"
              '';
            };

            Install = {
              WantedBy = ["default.target"];
            };
          };
        })
      ];
    };
  };
}

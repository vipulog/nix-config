{
  den,
  self,
  ...
}: {
  den.aspects.igloo.provides.tux.restic = {
    includes = [den.aspects.igloo.provides.tux.restic.secrets];

    homeManager = {config, ...}: let
      homeDir = config.home.homeDirectory;
    in {
      services.restic = {
        enable = true;

        backups.b2 = {
          initialize = true;
          repository = "b2:vipulog-restic:backups";

          runCheck = true;
          extraBackupArgs = ["--exclude-if-present=.nobackup"];
          pruneOpts = ["--keep-within 14d"];

          timerConfig = {
            OnCalendar = "daily";
            Persistent = true;
            RandomizedDelaySec = "1h";
          };

          paths = [
            "${homeDir}/Documents"
            "${homeDir}/Pictures"
            "${homeDir}/DCIM"
            "${homeDir}/Videos"
            "${homeDir}/Music"
            "${homeDir}/Recordings"
            "${homeDir}/Dev"
          ];

          exclude = [
            "**/.stversions"
            "**/node_modules"
            "**/.venv"
            "**/venv"
            "**/__pycache__"
            "**/target"
            "**/dist"
            "**/build"
            "**/.cache"
            "*.tmp"
            "*.swp"
          ];
        };
      };
    };

    secrets = let
      inherit (self.lib.den.sops-nix) userHasSops;
    in {
      homeManager = {
        lib,
        user,
        config,
        ...
      }:
        lib.mkIf (userHasSops {inherit den user;}) {
          sops = {
            secrets = {
              b2-app-key-id = {};
              b2-app-key = {};
              restic-password = {};
            };

            templates.restic-b2-env = {
              content = ''
                B2_ACCOUNT_ID=${config.sops.placeholder.b2-app-key-id}
                B2_ACCOUNT_KEY=${config.sops.placeholder.b2-app-key}
              '';
            };
          };

          services.restic.backups.b2 = {
            environmentFile = config.sops.templates.restic-b2-env.path;
            passwordFile = config.sops.secrets.restic-password.path;
          };
        };
    };

    persist-user = {
      directories = [
        ".cache/restic-backups-b2"
      ];
    };
  };
}

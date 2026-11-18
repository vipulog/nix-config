{
  den.aspects."tux@igloo".restic = {
    homeManager = {config, ...}: let
      homeDir = config.home.homeDirectory;
    in {
      sops = {
        secrets = {
          personal-backup-b2-app-key-id = {};
          personal-backup-b2-app-key = {};
          personal-backup-restic-password = {};
        };

        templates.personal-backup-restic-env = {
          content = ''
            B2_ACCOUNT_ID=${config.sops.placeholder.personal-backup-b2-app-key-id}
            B2_ACCOUNT_KEY=${config.sops.placeholder.personal-backup-b2-app-key}
          '';
        };
      };

      services.restic.backups.personal-backup = {
        environmentFile = config.sops.templates.personal-backup-restic-env.path;
        passwordFile = config.sops.secrets.personal-backup-restic-password.path;
      };

      services.restic = {
        enable = true;

        backups.personal-backup = {
          repository = "b2:vipulog:personal-backup";
          initialize = true;
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
            "**/.stfolder"
            "**/.thumbnails"
            "**/.trashed**"
            "**/node_modules"
            "**/.venv"
            "**/venv"
            "**/__pycache__"
            "**/.cache"
            "*.tmp"
            "*.swp"
          ];
        };
      };
    };

    persist-user = {
      directories = {
        ".cache/restic-backups-personal-backup".enable = true;
      };
    };
  };
}

{
  den.aspects.glacier.restic = {
    nixos = {
      config,
      pkgs,
      lib,
      ...
    }: {
      sops = {
        secrets = {
          personal-backup-b2-app-key-id = {};
          personal-backup-b2-app-key = {};
          personal-backup-restic-password = {};

          vaultwarden-backup-b2-app-key-id = {};
          vaultwarden-backup-b2-app-key = {};
          vaultwarden-backup-restic-password = {};
        };

        templates.personal-backup-restic-b2-env.content = ''
          B2_ACCOUNT_ID=${config.sops.placeholder.personal-backup-b2-app-key-id}
          B2_ACCOUNT_KEY=${config.sops.placeholder.personal-backup-b2-app-key}
        '';

        templates.vaultwarden-backup-restic-b2-env.content = ''
          B2_ACCOUNT_ID=${config.sops.placeholder.vaultwarden-backup-b2-app-key-id}
          B2_ACCOUNT_KEY=${config.sops.placeholder.vaultwarden-backup-b2-app-key}
        '';
      };

      services.restic.backups = {
        personal-backup = {
          repository = "b2:vipulog:personal-backup";

          environmentFile = config.sops.templates.personal-backup-restic-b2-env.path;
          passwordFile = config.sops.secrets.personal-backup-restic-password.path;

          initialize = true;
          runCheck = true;

          paths = [
            "/srv/syncthing/Backups"
            "/srv/syncthing/DCIM"
            "/srv/syncthing/Documents"
            "/srv/syncthing/Pictures"
            "/srv/syncthing/Projects"
            "/srv/syncthing/Recordings"
            "/srv/syncthing/Videos"
          ];

          backupPrepareCommand = ''
            touch /srv/syncthing/Documents/.resticignore
          '';

          extraBackupArgs = [
            "--exclude-file=/srv/syncthing/Documents/.resticignore"
            "--exclude-if-present=.nobackup"
          ];

          exclude = [
            ".stversions"
            ".stfolder"
            ".thumbnails"
            ".trashed*"
            "*.swp"
            "*.swo"
            "*~"
            ".#*"
            "#*#"
            ".direnv"
            ".devenv"
            "node_modules"
            ".next"
            ".nuxt"
            ".svelte-kit"
            ".astro"
            ".turbo"
            ".parcel-cache"
            ".vite"
            ".eslintcache"
            ".stylelintcache"
            "*.tsbuildinfo"
            "npm-debug.log*"
            "yarn-debug.log*"
            "yarn-error.log*"
            ".pnpm-debug.log*"
            ".venv"
            "venv"
            "__pycache__"
            "*.py[cod]"
            "*.egg-info"
            ".pytest_cache"
            ".mypy_cache"
            ".ruff_cache"
            ".tox"
            ".nox"
            ".ipynb_checkpoints"
            "htmlcov"
            ".coverage"
            ".clangd"
            ".ccls-cache"
            "CMakeFiles"
            "CMakeCache.txt"
            "*.o"
            "*.obj"
            ".gradle"
            ".mvn"
          ];

          pruneOpts = [
            "--keep-daily 7"
            "--keep-weekly 4"
            "--keep-monthly 12"
          ];

          timerConfig = {
            OnCalendar = "03:00";
            Persistent = true;
            RandomizedDelaySec = "30m";
          };
        };

        vaultwarden-backup = {
          repository = "b2:vipulog:vaultwarden-backup";

          environmentFile = config.sops.templates.vaultwarden-backup-restic-b2-env.path;
          passwordFile = config.sops.secrets.vaultwarden-backup-restic-password.path;

          initialize = true;
          runCheck = true;

          paths = [
            "/var/backup/vaultwarden"
          ];

          backupPrepareCommand = lib.concatStringsSep " " [
            "${pkgs.systemd}/bin/systemctl"
            "start"
            "--wait"
            "backup-vaultwarden.service"
          ];

          pruneOpts = [
            "--keep-daily 7"
            "--keep-weekly 4"
            "--keep-monthly 12"
          ];

          timerConfig = {
            OnCalendar = "02:00";
            Persistent = true;
            RandomizedDelaySec = "30m";
          };
        };
      };
    };

    persist-host = {
      directories = {
        "/var/cache/restic-backups-personal-backup" = {
          enable = true;
          mode = "0700";
        };

        "/var/cache/restic-backups-vaultwarden-backup" = {
          enable = true;
          mode = "0700";
        };
      };
    };
  };
}

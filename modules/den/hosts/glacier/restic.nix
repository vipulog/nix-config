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
          vaultwarden-b2-app-key-id = {};
          vaultwarden-b2-app-key = {};
          vaultwarden-restic-password = {};
        };

        templates.vaultwarden-restic-b2-env.content = ''
          B2_ACCOUNT_ID=${config.sops.placeholder.vaultwarden-b2-app-key-id}
          B2_ACCOUNT_KEY=${config.sops.placeholder.vaultwarden-b2-app-key}
        '';
      };

      services.restic.backups.vaultwarden = {
        repository = "b2:vipulog:vaultwarden";

        environmentFile = config.sops.templates.vaultwarden-restic-b2-env.path;
        passwordFile = config.sops.secrets.vaultwarden-restic-password.path;

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

    persist-host = {
      directories = {
        "/var/cache/restic-backups-vaultwarden" = {
          enable = true;
          mode = "0700";
        };
      };
    };
  };
}

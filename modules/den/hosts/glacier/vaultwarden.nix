{den, ...}: {
  den.aspects.glacier.vaultwarden = {
    includes = [den.aspects.glacier.restic];

    nixos = {
      config,
      lib,
      ...
    }: {
      sops = {
        secrets.vaultwarden-admin-token = {};

        templates.vaultwarden-env.content = ''
          ADMIN_TOKEN=${config.sops.placeholder.vaultwarden-admin-token}
        '';
      };

      services.vaultwarden = {
        enable = true;
        domain = "vault.vipulog.duckdns.org";
        dbBackend = "sqlite";
        backupDir = "/var/backup/vaultwarden";
        environmentFile = config.sops.templates.vaultwarden-env.path;

        config = {
          DATA_FOLDER = "/srv/vaultwarden";
          SIGNUPS_ALLOWED = false;
          ROCKET_ADDRESS = "127.0.0.1";
          ROCKET_PORT = 8000;
        };
      };

      systemd = {
        services = {
          vaultwarden.serviceConfig = {
            ReadWritePaths = ["/srv/vaultwarden"];
          };

          backup-vaultwarden = {
            environment.DATA_FOLDER = lib.mkForce "/srv/vaultwarden";
          };
        };

        tmpfiles.rules = [
          "d /srv/vaultwarden 0700 vaultwarden vaultwarden -"
        ];
      };
    };

    persist-host = {
      directories = {
        "/var/backup/vaultwarden" = {
          enable = true;
          user = "vaultwarden";
          group = "vaultwarden";
          mode = "0770";
        };
      };
    };
  };
}

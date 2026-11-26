{
  den.aspects.glacier.vaultwarden = {
    nixos = {config, ...}: let
      svc = config.glacier.services.vaultwarden;
    in {
      glacier.services.vaultwarden = {
        subdomain = "vault";
        port = 8000;

        homepage = {
          group = "Your data";
          order = 20;
          title = "Vaultwarden";
          icon = "vaultwarden.svg";
          description = "Password Manager";
        };
      };

      sops = {
        secrets.vaultwarden-admin-token = {};

        templates.vaultwarden-env.content = ''
          ADMIN_TOKEN=${config.sops.placeholder.vaultwarden-admin-token}
        '';
      };

      services.vaultwarden = {
        enable = true;
        domain = svc.fqdn;
        dbBackend = "sqlite";
        backupDir = "/var/backup/vaultwarden";
        environmentFile = config.sops.templates.vaultwarden-env.path;

        config = {
          DATA_FOLDER = "/srv/vaultwarden";
          SIGNUPS_ALLOWED = false;
          ROCKET_ADDRESS = svc.host;
          ROCKET_PORT = svc.port;
        };
      };

      systemd = {
        services.vaultwarden.serviceConfig = {
          ReadWritePaths = ["/srv/vaultwarden"];
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
          mode = "0700";
        };
      };
    };
  };
}

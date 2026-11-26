{
  lib,
  self,
  ...
}: {
  den.aspects.glacier.beszel = {
    nixos = {config, ...}: let
      svc = config.glacier.services.beszel;
    in {
      glacier.services.beszel = {
        subdomain = "beszel";
        port = 8090;

        proxy.extraConfig = ''
          proxy_buffering off;
          proxy_read_timeout 600s;
          proxy_send_timeout 600s;
          send_timeout 600s;
        '';

        homepage = {
          group = "Monitoring";
          order = 20;
          title = "Beszel";
          icon = "beszel.svg";
          description = "System Metrics";
        };
      };

      services.beszel = {
        hub = {
          enable = true;
          inherit (svc) host port;

          environment = {
            APP_URL = svc.url;
          };
        };

        agent = {
          enable = true;

          environment = {
            LISTEN = "127.0.0.1:45876";
            KEY_FILE = "${self}/modules/den/hosts/glacier/res/id_beszel_glacier.pub";
            FILESYSTEM = "sda3__system";
            EXTRA_FILESYSTEMS = "sdb__data";
          };
        };
      };

      users.users = {
        beszel-hub = {
          isSystemUser = true;
          group = "beszel-hub";
        };

        beszel-agent = {
          isSystemUser = true;
          group = "beszel-agent";
        };
      };

      users.groups = {
        beszel-hub = {};
        beszel-agent = {};
      };

      systemd.services.beszel-hub.serviceConfig = {
        DynamicUser = lib.mkForce false;
        User = "beszel-hub";
        Group = "beszel-hub";
      };

      systemd.services.beszel-agent.serviceConfig = {
        DynamicUser = lib.mkForce false;
        User = "beszel-agent";
        Group = "beszel-agent";
      };
    };

    persist-host = {
      directories = {
        "/var/lib/beszel-hub" = {
          enable = true;
          user = "beszel-hub";
          group = "beszel-hub";
          mode = "0700";
        };
      };
    };
  };
}

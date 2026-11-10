{
  lib,
  self,
  ...
}: {
  den.aspects.glacier.beszel = {
    nixos = {
      services.beszel = {
        hub = {
          enable = true;
          host = "127.0.0.1";
          port = 8090;

          environment = {
            APP_URL = "https://beszel.vipulog.duckdns.org";
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

{lib, ...}: {
  den.aspects.glacier.uptime-kuma = {
    nixos = {config, ...}: let
      svc = config.glacier.services."uptime-kuma";
    in {
      glacier.services."uptime-kuma" = {
        subdomain = "status";
        port = 3001;

        homepage = {
          group = "Monitoring";
          order = 30;
          title = "Uptime Kuma";
          icon = "uptime-kuma.svg";
          description = "Service Health";
        };
      };

      services.uptime-kuma = {
        enable = true;

        settings = {
          HOST = svc.host;
          PORT = toString svc.port;
        };
      };

      users.users.uptime-kuma = {
        isSystemUser = true;
        group = "uptime-kuma";
      };

      users.groups.uptime-kuma = {};

      systemd.services.uptime-kuma.serviceConfig = {
        DynamicUser = lib.mkForce false;
        User = "uptime-kuma";
        Group = "uptime-kuma";
      };
    };

    persist-host = {
      directories = {
        "/var/lib/uptime-kuma" = {
          enable = true;
          user = "uptime-kuma";
          group = "uptime-kuma";
          mode = "0700";
        };
      };
    };
  };
}

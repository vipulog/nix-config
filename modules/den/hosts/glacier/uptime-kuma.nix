{lib, ...}: {
  den.aspects.glacier.uptime-kuma = {
    nixos = {
      services.uptime-kuma = {
        enable = true;

        settings = {
          HOST = "127.0.0.1";
          PORT = "3001";
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

{lib, ...}: {
  den.aspects.glacier.ntfy = {
    nixos = {
      services.ntfy-sh = {
        enable = true;

        settings = {
          base-url = "https://ntfy.vipulog.duckdns.org";
          listen-http = "127.0.0.1:2586";
          behind-proxy = true;
        };
      };

      users.users.ntfy-sh = {
        isSystemUser = true;
        group = "ntfy-sh";
      };

      users.groups.ntfy-sh = {};

      systemd.services.ntfy-sh.serviceConfig = {
        DynamicUser = lib.mkForce false;
        User = "ntfy-sh";
        Group = "ntfy-sh";
      };
    };

    persist-host = {
      directories = {
        "/var/lib/ntfy-sh" = {
          enable = true;
          user = "ntfy-sh";
          group = "ntfy-sh";
          mode = "0700";
        };
      };
    };
  };
}

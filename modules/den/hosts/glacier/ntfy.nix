{lib, ...}: {
  den.aspects.glacier.ntfy = {
    nixos = {config, ...}: let
      svc = config.glacier.services.ntfy;
    in {
      glacier.services.ntfy = {
        subdomain = "ntfy";
        port = 2586;

        proxy.extraConfig = ''
          proxy_buffering off;
          proxy_read_timeout 600s;
          proxy_send_timeout 600s;
          send_timeout 600s;
        '';

        homepage = {
          group = "Monitoring";
          order = 10;
          title = "ntfy";
          icon = "ntfy.svg";
          description = "Push Notifications";
        };
      };

      services.ntfy-sh = {
        enable = true;

        settings = {
          base-url = svc.url;
          listen-http = svc.localAddr;
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

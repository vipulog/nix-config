{
  den.aspects.glacier.immich = {
    nixos = {config, ...}: let
      svc = config.glacier.services.immich;
    in {
      glacier.services.immich = {
        subdomain = "photos";
        port = 2283;

        proxy.extraConfig = ''
          proxy_request_buffering off;
          proxy_read_timeout 600s;
          proxy_send_timeout 600s;
          send_timeout 600s;
        '';

        homepage = {
          group = "Your data";
          order = 30;
          title = "Immich";
          icon = "immich.svg";
          description = "Photos & Videos";
        };
      };

      services.immich = {
        enable = true;
        inherit (svc) host port;
        mediaLocation = "/srv/immich/media";

        settings = {
          server.externalDomain = svc.url;
        };
      };

      users.users.immich.extraGroups = [
        "synced"
        "synced-media"
      ];

      systemd.tmpfiles.rules = [
        "d /srv/immich 0700 immich immich -"
        "d /srv/immich/media 0700 immich immich -"
      ];
    };

    persist-host = {
      directories = {
        "/var/cache/immich" = {
          enable = true;
          user = "immich";
          group = "immich";
          mode = "0700";
        };
      };
    };
  };
}

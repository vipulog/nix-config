{
  den.aspects.glacier.immich = {
    nixos = {
      services.immich = {
        enable = true;
        host = "127.0.0.1";
        port = 2283;
        mediaLocation = "/srv/immich/media";

        settings = {
          server.externalDomain = "https://photos.vipulog.duckdns.org";
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

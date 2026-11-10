{den, ...}: {
  den.aspects.glacier.immich = {
    includes = [den.aspects.glacier.postgresql];

    nixos = {pkgs, ...}: {
      services.immich = {
        enable = true;
        package = pkgs.unstable.immich;
        host = "127.0.0.1";
        port = 2283;
        mediaLocation = "/srv/immich/media";

        settings = {
          server.externalDomain = "https://photos.vipulog.duckdns.org";
        };
      };

      systemd.tmpfiles.rules = [
        "d /srv/immich 0750 immich immich -"
        "d /srv/immich/media 0750 immich immich -"
      ];
    };

    persist-host = {
      directories = {
        "/var/cache/immich" = {
          enable = true;
          user = "immich";
          group = "immich";
          mode = "0750";
        };
      };
    };
  };
}

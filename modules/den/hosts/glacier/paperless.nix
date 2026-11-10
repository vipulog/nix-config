{
  den.aspects.glacier.paperless = {
    nixos = {
      services.paperless = {
        enable = true;
        address = "127.0.0.1";
        port = 28981;
        domain = "docs.vipulog.duckdns.org";
        dataDir = "/srv/paperless";
      };

      systemd.tmpfiles.rules = [
        "d /srv/paperless 0750 paperless paperless -"
      ];
    };

    persist-host = {
      directories = {
        "/var/cache/paperless" = {
          enable = true;
          user = "paperless";
          group = "paperless";
          mode = "0750";
        };
      };
    };
  };
}

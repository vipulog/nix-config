{
  den.aspects.glacier.paperless = {
    nixos = {lib, ...}: {
      services.paperless = {
        enable = true;
        address = "127.0.0.1";
        port = 28981;
        domain = "docs.vipulog.duckdns.org";
        dataDir = "/srv/paperless";

        settings = {
          PAPERLESS_FILENAME_FORMAT = "{{ title }}";
          PAPERLESS_ARCHIVE_FILE_GENERATION = "always";
          PAPERLESS_AI_ENABLED = true;
          PAPERLESS_AI_LLM_EMBEDDING_BACKEND = "huggingface";
        };
      };

      users.users.paperless.extraGroups = [
        "synced"
        "synced-docs"
      ];

      systemd.services = {
        paperless-task-queue.serviceConfig = {
          UMask = lib.mkForce "0007";
          MemoryDenyWriteExecute = lib.mkForce false;
        };

        paperless-web.serviceConfig = {
          MemoryDenyWriteExecute = lib.mkForce false;
        };
      };

      fileSystems."/srv/paperless/media/documents/archive" = {
        device = "/srv/syncthing/Documents/Paperless";
        fsType = "none";

        options = [
          "bind"
          "nofail"
          "x-systemd.after=systemd-tmpfiles-setup.service"
        ];
      };

      systemd.tmpfiles.rules = [
        "d /srv/paperless 0700 paperless paperless -"
        "d /srv/paperless/media 0700 paperless paperless -"
        "d /srv/paperless/media/documents 0700 paperless paperless -"
        "d /srv/paperless/media/documents/originals 0700 paperless paperless -"
        "d /srv/paperless/media/documents/thumbnails 0700 paperless paperless -"
        "d /srv/paperless/media/documents/archive 0700 paperless paperless -"
        "d /srv/syncthing/Documents/Paperless 2770 syncthing synced-docs -"
      ];
    };

    persist-host = {
      directories = {
        "/var/cache/paperless" = {
          enable = true;
          user = "paperless";
          group = "paperless";
          mode = "0700";
        };
      };
    };
  };
}

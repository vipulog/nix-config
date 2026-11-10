{
  den.aspects.glacier.homepage = {
    nixos = let
      domain = "vipulog.duckdns.org";

      homepageRes = builtins.fetchTarball {
        url = "https://gist.github.com/vipulog/fccca0741532e09aba17a243ddc4fd28/archive/7f80daf36e97793407e040016c285c97ab90dba6.tar.gz";
        sha256 = "sha256-JGYElV1X41LCjpUICOEqczC1jt222E6ehXHX/4W9NNg=";
      };
    in {
      services.homepage-dashboard = {
        enable = true;
        listenPort = 8082;
        allowedHosts = domain;

        settings = {
          title = "glacier";

          background = {
            image = "https://bingw.jasonzeng.dev/?index=0&resolution=1920x1080";
            opacity = 85;
            blur = "30px";
          };
        };

        customCSS = builtins.readFile "${homepageRes}/homepage.css";
        customJS = builtins.readFile "${homepageRes}/homepage.js";

        widgets = [
          {
            resources = {
              cpu = true;
              memory = true;
              uptime = true;
            };
          }
        ];

        services = [
          {
            "Your data" = [
              {
                "Syncthing" = {
                  icon = "syncthing.svg";
                  href = "https://sync.${domain}";
                  description = "File Synchronization";
                  siteMonitor = "http://127.0.0.1:8384";
                };
              }

              {
                "Vaultwarden" = {
                  icon = "vaultwarden.svg";
                  href = "https://vault.${domain}";
                  description = "Password Manager";
                  siteMonitor = "http://127.0.0.1:8000";
                };
              }

              {
                "Immich" = {
                  icon = "immich.svg";
                  href = "https://photos.${domain}";
                  description = "Photos & Videos";
                  siteMonitor = "http://127.0.0.1:2283";
                };
              }

              {
                "Paperless" = {
                  icon = "paperless-ngx.svg";
                  href = "https://docs.${domain}";
                  description = "Document Archive";
                  siteMonitor = "http://127.0.0.1:28981";
                };
              }
            ];
          }

          {
            "Monitoring" = [
              {
                "ntfy" = {
                  icon = "ntfy.svg";
                  href = "https://ntfy.${domain}";
                  description = "Push Notifications";
                  siteMonitor = "http://127.0.0.1:2586";
                };
              }

              {
                "Beszel" = {
                  icon = "beszel.svg";
                  href = "https://beszel.${domain}";
                  description = "System Metrics";
                  siteMonitor = "http://127.0.0.1:8090";
                };
              }

              {
                "Uptime Kuma" = {
                  icon = "uptime-kuma.svg";
                  href = "https://status.${domain}";
                  description = "Service Health";
                  siteMonitor = "http://127.0.0.1:3001";
                };
              }
            ];
          }
        ];
      };
    };
  };
}

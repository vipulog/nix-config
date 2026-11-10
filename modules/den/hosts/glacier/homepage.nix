{
  den.aspects.glacier.homepage = {
    nixos = let
      domain = "vipulog.duckdns.org";

      homepageRes = builtins.fetchTarball {
        url = "https://gist.github.com/vipulog/fccca0741532e09aba17a243ddc4fd28/archive/935afec777a53deb06c0d7acf04e137ec41bf613.tar.gz";
        sha256 = "sha256-/ju85OwxiRipiriRKJ58arXrxnbyuZnmYQmOeNzt1z8=";
      };
    in {
      services.homepage-dashboard = {
        enable = true;
        listenPort = 8082;
        allowedHosts = "${domain},localhost:8082,127.0.0.1:8082";

        settings = {
          title = "glacier";

          background = {
            image = "https://bingw.jasonzeng.dev/?index=0&resolution=UHD";
            opacity = 85;
            blur = "60px";
          };
        };

        customCSS = builtins.readFile "${homepageRes}/homepage.css";
        customJS = builtins.readFile "${homepageRes}/homepage.js";

        services = [
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

          {
            "Your data" = [
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
        ];
      };
    };
  };
}

{
  den.aspects.glacier.reverse-proxy = {
    nixos = {config, ...}: let
      domain = "vipulog.duckdns.org";
    in {
      sops = {
        secrets.duckdns-token = {};

        templates.duckdns-env.content = ''
          DUCKDNS_TOKEN=${config.sops.placeholder.duckdns-token}
        '';
      };

      security.acme = {
        acceptTerms = true;
        defaults.email = "vipultyagi@duck.com";

        certs.${domain} = {
          dnsProvider = "duckdns";
          environmentFile = config.sops.templates.duckdns-env.path;
          extraDomainNames = ["*.${domain}"];
          group = "nginx";
        };
      };

      services.nginx = {
        enable = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        clientMaxBodySize = "5000M";

        virtualHosts = {
          "_" = {
            default = true;
            useACMEHost = domain;
            onlySSL = true;

            locations."/".return = "404";
          };

          "${domain}" = {
            useACMEHost = domain;
            onlySSL = true;

            locations."/" = {
              proxyPass = "http://127.0.0.1:8082";
              proxyWebsockets = true;
            };
          };

          "sync.${domain}" = {
            useACMEHost = domain;
            onlySSL = true;

            locations."/" = {
              proxyPass = "http://127.0.0.1:8384";
              proxyWebsockets = true;

              extraConfig = ''
                proxy_buffering off;
                proxy_read_timeout 600s;
                proxy_send_timeout 600s;
                send_timeout 600s;
              '';
            };
          };

          "vault.${domain}" = {
            useACMEHost = domain;
            onlySSL = true;

            locations."/" = {
              proxyPass = "http://127.0.0.1:8000";
              proxyWebsockets = true;
            };
          };

          "photos.${domain}" = {
            useACMEHost = domain;
            onlySSL = true;

            locations."/" = {
              proxyPass = "http://127.0.0.1:2283";
              proxyWebsockets = true;

              extraConfig = ''
                proxy_request_buffering off;
                proxy_read_timeout 600s;
                proxy_send_timeout 600s;
                send_timeout 600s;
              '';
            };
          };

          "docs.${domain}" = {
            useACMEHost = domain;
            onlySSL = true;

            locations."/" = {
              proxyPass = "http://127.0.0.1:28981";
              proxyWebsockets = true;

              extraConfig = ''
                proxy_request_buffering off;
                proxy_read_timeout 600s;
                proxy_send_timeout 600s;
                send_timeout 600s;
              '';
            };
          };

          "ntfy.${domain}" = {
            useACMEHost = domain;
            onlySSL = true;

            locations."/" = {
              proxyPass = "http://127.0.0.1:2586";
              proxyWebsockets = true;

              extraConfig = ''
                proxy_buffering off;
                proxy_read_timeout 600s;
                proxy_send_timeout 600s;
                send_timeout 600s;
              '';
            };
          };

          "status.${domain}" = {
            useACMEHost = domain;
            onlySSL = true;

            locations."/" = {
              proxyPass = "http://127.0.0.1:3001";
              proxyWebsockets = true;
            };
          };

          "beszel.${domain}" = {
            useACMEHost = domain;
            onlySSL = true;

            locations."/" = {
              proxyPass = "http://127.0.0.1:8090";
              proxyWebsockets = true;

              extraConfig = ''
                proxy_buffering off;
                proxy_read_timeout 600s;
                proxy_send_timeout 600s;
                send_timeout 600s;
              '';
            };
          };
        };
      };
    };

    persist-host = {
      directories = {
        "/var/lib/acme" = {
          enable = true;
          user = "acme";
          group = "nginx";
          mode = "0750";
        };
      };
    };
  };
}

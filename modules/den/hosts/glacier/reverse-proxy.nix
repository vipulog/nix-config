{
  den.aspects.glacier.reverse-proxy = {
    nixos = {
      config,
      lib,
      ...
    }: let
      inherit (config.glacier) domain services;

      mkVhost = svc: {
        useACMEHost = domain;
        onlySSL = true;

        locations."/" = {
          proxyPass = "http://${svc.localAddr}";
          proxyWebsockets = true;
          extraConfig = lib.mkIf (svc.proxy.extraConfig != "") svc.proxy.extraConfig;
        };
      };

      serviceVhosts = lib.pipe services [
        (lib.filterAttrs (_: svc: svc.proxy.enable))
        (lib.mapAttrs' (_: svc: lib.nameValuePair svc.fqdn (mkVhost svc)))
      ];
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

        virtualHosts = lib.mkMerge [
          {
            "_" = {
              default = true;
              useACMEHost = domain;
              onlySSL = true;

              locations."/".return = "404";
            };
          }

          serviceVhosts
        ];
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

{
  den.aspects.glacier.homepage = {
    nixos = {
      config,
      lib,
      ...
    }: let
      inherit (config.glacier) domain services;
      svc = services.homepage;

      homepageRes = builtins.fetchTarball {
        url = "https://gist.github.com/vipulog/fccca0741532e09aba17a243ddc4fd28/archive/7f80daf36e97793407e040016c285c97ab90dba6.tar.gz";
        sha256 = "sha256-JGYElV1X41LCjpUICOEqczC1jt222E6ehXHX/4W9NNg=";
      };

      homepageSvcs = builtins.filter (s: s.homepage != null) (builtins.attrValues services);

      groups = ["Your data" "Monitoring"];

      groupOrder = lib.unique (
        (builtins.filter (g: builtins.any (s: s.homepage.group == g) homepageSvcs) groups)
        ++ map (s: s.homepage.group) homepageSvcs
      );

      mkGroup = groupName: {
        ${groupName} = lib.pipe homepageSvcs [
          (builtins.filter (s: s.homepage.group == groupName))
          (builtins.sort (a: b: a.homepage.order < b.homepage.order))
          (map (s: {
            ${s.homepage.title} = {
              inherit (s.homepage) icon description;
              href = s.url;
              siteMonitor = "http://${s.localAddr}";
            };
          }))
        ];
      };
    in {
      glacier.services.homepage = {
        port = 8082;
      };

      services.homepage-dashboard = {
        enable = true;
        listenPort = svc.port;
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

        services = map mkGroup groupOrder;
      };
    };
  };
}

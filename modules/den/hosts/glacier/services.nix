{
  den.aspects.glacier.services = {
    nixos = {
      config,
      lib,
      ...
    }: let
      cfg = config.glacier;
    in {
      options.glacier = {
        domain = lib.mkOption {
          type = lib.types.str;
          default = "vipulog.duckdns.org";
          description = "Base domain for glacier services.";
        };

        services = lib.mkOption {
          default = {};
          description = "Web-exposed services on glacier.";

          type = lib.types.attrsOf (lib.types.submodule ({config, ...}: {
            options = {
              subdomain = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
                description = "Subdomain prefix; null serves at the apex domain.";
              };

              host = lib.mkOption {
                type = lib.types.str;
                default = "127.0.0.1";
                description = "Local bind address.";
              };

              port = lib.mkOption {
                type = lib.types.port;
                description = "Local listen port.";
              };

              fqdn = lib.mkOption {
                type = lib.types.str;
                readOnly = true;
                description = "Computed fully-qualified domain name.";

                default =
                  if config.subdomain == null
                  then cfg.domain
                  else "${config.subdomain}.${cfg.domain}";
              };

              url = lib.mkOption {
                type = lib.types.str;
                readOnly = true;
                default = "https://${config.fqdn}";
                description = "Computed public HTTPS URL.";
              };

              localAddr = lib.mkOption {
                type = lib.types.str;
                readOnly = true;
                default = "${config.host}:${toString config.port}";
                description = "Computed host:port listen address.";
              };

              proxy = {
                enable = lib.mkOption {
                  type = lib.types.bool;
                  default = true;
                  description = "Whether to expose via nginx reverse proxy.";
                };

                extraConfig = lib.mkOption {
                  type = lib.types.lines;
                  default = "";
                  description = "Extra nginx location configuration.";
                };
              };

              homepage = lib.mkOption {
                default = null;
                description = "Optional Homepage dashboard card metadata.";

                type = lib.types.nullOr (lib.types.submodule {
                  options = {
                    group = lib.mkOption {
                      type = lib.types.str;
                      description = "Dashboard section name.";
                    };

                    title = lib.mkOption {
                      type = lib.types.str;
                      description = "Card display title.";
                    };

                    icon = lib.mkOption {
                      type = lib.types.str;
                      description = "Card icon filename.";
                    };

                    description = lib.mkOption {
                      type = lib.types.str;
                      description = "Short card description.";
                    };

                    order = lib.mkOption {
                      type = lib.types.int;
                      default = 100;
                      description = "Sort order within the dashboard section.";
                    };
                  };
                });
              };
            };
          }));
        };
      };
    };
  };
}

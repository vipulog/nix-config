{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.services.networking.firewall;
in {
  options.internal.services.networking.firewall = {
    enable = mkEnableOption "firewall rules";

    globalTCP = mkOption {
      type = types.listOf types.port;
      default = [];
      description = "List of TCP ports to allow globally.";
    };

    globalUDP = mkOption {
      type = types.listOf types.port;
      default = [];
      description = "List of UDP ports to allow globally.";
    };

    interfaces = mkOption {
      type = types.attrsOf (types.submodule {
        options = {
          tcp = mkOption {
            type = types.listOf types.port;
            default = [];
            description = "List of TCP ports to allow on this interface.";
          };
          udp = mkOption {
            type = types.listOf types.port;
            default = [];
            description = "List of UDP ports to allow on this interface.";
          };
        };
      });
      default = {};
      description = "Attribute set of interface-specific firewall rules.";
    };
  };

  config = mkIf cfg.enable {
    networking.firewall = {
      allowedTCPPorts = cfg.globalTCP;
      allowedUDPPorts = cfg.globalUDP;
    };

    networking.firewall.interfaces =
      mapAttrs (_name: cfg: {
        allowedTCPPorts = cfg.tcp;
        allowedUDPPorts = cfg.udp;
      })
      cfg.interfaces;
  };
}

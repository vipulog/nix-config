{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.services.networking.firewall;
in {
  options.internal.services.networking.firewall = {
    interface = mkOption {
      type = types.str;
      default = "";
      description = "Interface to open ports on.";
    };

    udp = mkOption {
      type = types.listOf types.port;
      default = [];
      description = "List of UDP ports to allow.";
    };

    tcp = mkOption {
      type = types.listOf types.port;
      default = [];
      description = "List of TCP ports to allow.";
    };
  };

  config = mkIf (cfg.interface != "") {
    networking.firewall.interfaces.${cfg.interface} = {
      allowedTCPPorts = cfg.tcp;
      allowedUDPPorts = cfg.udp;
    };
  };
}

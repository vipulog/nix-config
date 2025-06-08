{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.internal.services.tailscale;
  exitNodeEnabled = cfg.exitNode.wanInterface != "";
in {
  options.internal.services.tailscale = {
    enable = mkEnableOption "Tailscale";
    enableSSH = mkEnableOption "Tailscale SSH";

    exitNode.wanInterface = mkOption {
      type = types.str;
      default = "";
      description = "If this host should be an exit node, specify the WAN interface.";
    };
  };

  config = mkIf cfg.enable {
    systemd.services.tailscaled = {
      after = ["network-online.target"];
      wants = ["network-online.target"];
    };

    services.tailscale = {
      enable = true;
      openFirewall = true;
      useRoutingFeatures =
        if exitNodeEnabled
        then "both"
        else "client";
      extraUpFlags = lists.optionals cfg.enableSSH ["--ssh"];
      extraSetFlags = lists.optionals exitNodeEnabled ["--advertise-exit-node"];
    };

    systemd.services.tailscale-transport-layer-offloads = mkIf exitNodeEnabled {
      # See https://tailscale.com/kb/1320/performance-best-practices#ethtool-configuration.
      description = "Tailscale: better performance for exit nodes";

      after = ["network.target"];
      wantedBy = ["default.target"];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = ''
          ${getExe pkgs.ethtool} \
            -K ${cfg.exitNode.wanInterface} \
            rx-udp-gro-forwarding on \
            rx-gro-list off
        '';
      };
    };

    environment.systemPackages = lists.optionals exitNodeEnabled [pkgs.ethtool];
  };
}

{ username, ... }: {
  services.tailscale = {
    enable = true;
    extraUpFlags = [ "--ssh" "--operator=${username}" ];
    useRoutingFeatures = "client";
  };
  networking.nameservers = [ "100.100.100.100" "8.8.8.8" "1.1.1.1" ];
  networking.search = [ "tailed69d9.ts.net" ];
}

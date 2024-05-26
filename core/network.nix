{ username, hostname, ... }: {
  networking = {
    networkmanager.enable = true;
    hostName = hostname;

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 80 443 3389 ];
      allowedUDPPorts = [ ];
    };
  };

  users.users.${username}.extraGroups = [ "networkmanager" ];
}

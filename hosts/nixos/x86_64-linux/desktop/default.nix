{...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  config = {
    internal = {
      users.vipul.enable = true;
      roles.workstation.enable = true;
      services.networking.users = ["vipul"];
      misc.disko.enable = true;
    };

    # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "24.11";
  };
}

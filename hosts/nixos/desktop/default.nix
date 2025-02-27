{...}: {
  imports = [
    ./hardware.nix
    ./users
  ];

  config = {
    internal = {
      roles.workstation.enable = true;
    };

    # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "24.11";
  };
}

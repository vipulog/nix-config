{
  den.aspects.sudo = {
    nixos = {
      security.sudo.enable = true;
    };

    persist = {
      preserve.directories = [
        "/var/db/sudo"
      ];
    };
  };
}

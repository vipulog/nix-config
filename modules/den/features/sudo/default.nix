{
  den.aspects.sudo = {
    nixos = {
      security.sudo.enable = true;
    };

    persist-host = {
      directories = [
        "/var/db/sudo"
      ];
    };
  };
}

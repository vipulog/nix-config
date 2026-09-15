{den, ...}: {
  den.aspects.igloo.tux = {
    includes = [
      den.aspects.igloo.tux.syncthing
      den.aspects.igloo.tux.restic
    ];

    nixos = {
      sops.secrets.tux-password = {
        neededForUsers = true;
      };

      services.tailscale.extraSetFlags = [
        "--operator=tux"
      ];
    };

    user = {config, ...}: {
      hashedPasswordFile = config.sops.secrets.tux-password.path;
    };

    homeManager = {
      home.stateVersion = "26.05";
    };

    persist = {
      preserve.users.tux.directories = [
        "DCIM"
        "Recordings"
      ];
    };
  };
}

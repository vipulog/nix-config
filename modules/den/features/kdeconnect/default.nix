{
  den.aspects.kdeconnect = {user}: {
    nixos = {
      programs.kdeconnect.enable = true;
    };

    homeManager = {
      services.kdeconnect.enable = true;
    };

    persist = {
      preserve.users.${user.name}.directories = [
        ".config/kdeconnect"
      ];
    };
  };
}

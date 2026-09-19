{
  den.aspects.kdeconnect = {
    nixos = {
      programs.kdeconnect.enable = true;
    };

    homeManager = {
      services.kdeconnect.enable = true;
    };

    persist-user = {
      directories = [
        ".config/kdeconnect"
      ];
    };
  };
}

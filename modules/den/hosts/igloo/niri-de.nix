{den, ...}: {
  den.aspects.igloo.niri-de = {
    includes = [den.aspects.niri-de];

    nixos = {config, ...}: let
      tux = config.users.users.tux;
    in {
      services.displayManager = {
        autoLogin = {
          enable = true;
          user = tux.name;
        };

        dux-greeter = {
          configHome = tux.home;
        };
      };
    };
  };
}

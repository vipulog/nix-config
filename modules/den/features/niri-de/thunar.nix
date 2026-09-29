{
  den.aspects.niri-de.thunar = {user}: {
    nixos = {
      programs = {
        thunar.enable = true;
        xfconf.enable = true;
      };

      services = {
        gvfs.enable = true;
        tumbler.enable = true;
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        ".config/Thunar"
        ".config/xfce4"
      ];
    };
  };
}

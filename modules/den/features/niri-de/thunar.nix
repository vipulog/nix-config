{
  den.aspects.niri-de.thunar = {
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

    persist-user = {
      directories = {
        ".config/Thunar".enable = true;
        ".config/xfce4".enable = true;
      };
    };
  };
}

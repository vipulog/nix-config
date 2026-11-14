{
  den.aspects.niri-de.gtk = {
    nixos = {pkgs, ...}: {
      programs.dconf.enable = true;

      environment.systemPackages = [
        pkgs.colloid-gtk-theme
        pkgs.colloid-icon-theme
        pkgs.bibata-cursors
        pkgs.inter
      ];
    };

    homeManager = {pkgs, ...}: {
      gtk = {
        enable = true;
        colorScheme = "dark";

        theme = {
          package = pkgs.colloid-gtk-theme;
          name = "Colloid-Dark";
        };

        iconTheme = {
          package = pkgs.colloid-icon-theme;
          name = "Colloid-Dark";
        };

        cursorTheme = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = 24;
        };

        font = {
          package = pkgs.inter;
          name = "Inter";
          size = 11;
        };
      };
    };
  };
}

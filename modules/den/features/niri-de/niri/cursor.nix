{
  den.aspects.niri-de.niri.cursor = {
    nixos = {pkgs, ...}: {
      environment.systemPackages = [
        pkgs.bibata-cursors
      ];
    };

    homeManager = {pkgs, ...}: {
      home.pointerCursor = {
        enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
        gtk.enable = true;
        x11.enable = true;
      };
    };
  };
}

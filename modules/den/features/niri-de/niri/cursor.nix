{
  den.aspects.niri-de.niri.cursor = {
    configKdl = ''
    '';

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

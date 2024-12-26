{ pkgs, home-manager, username, ... }: {
  home-manager.users.${username} = {
    gtk = {
      cursorTheme = {
        package = pkgs.apple-cursor;
        name = "macOS-BigSur";
      };
      iconTheme = {
        package = pkgs.colloid-icon-theme;
        name = "Colloid";
      };
    };
  };
}

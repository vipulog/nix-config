{ pkgs, username, mylib, theme, inputs, ... }: {

  imports = [ inputs.stylix.nixosModules.stylix ];

  # ---- Home Configuration ----
  home-manager.users.${username} = {
    stylix = {
      enable = true;
      targets = {
        gnome.enable = true;
        gtk.enable = true;
        gtk.extraCss = ''
          decoration, window, window.background, window.titlebar, .titlebar {
            border-radius: 0px;
          }
        '';
      };
    };
  };

  # ---- System Configuration ----
  stylix = {
    enable = true;
    autoEnable = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/brewer.yaml";
    image = mylib.relativeToRoot "assets/backgrounds/${theme}.jpg";
    polarity = "dark";
  };
}

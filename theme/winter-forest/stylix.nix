{ pkgs, username, mylib, theme, inputs, ... }: {

  imports = [ inputs.stylix.nixosModules.stylix ];

  # ---- Home Configuration ----
  home-manager.users.${username} = { lib, config, ... }: {
    home.activation.removeExistingGTKConfig = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
      rm -rf ${config.home.homeDirectory}/.config/gtk-*
    '';

    stylix = {
      enable = true;
      targets = {
        gnome.enable = true;
        zellij.enable = true;
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

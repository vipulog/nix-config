{ pkgs, username, lib, ... }: {

  imports = [ ./rdp.nix ];

  # ---- Home Configuration ----
  home-manager.users.${username} = { config, ... }: {
    imports = [ ./keybindings.nix ./extensions.nix ./preferences.nix ];
    home.packages = with pkgs; [ pop-launcher gnome-tweaks dconf-editor ];
  };

  # ---- System Configuration ----
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  programs.dconf.enable = true;

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gedit
    cheese
    epiphany
    simple-scan
    yelp
    gnome-contacts
    gnome-maps
    gnome-music
  ]);
}

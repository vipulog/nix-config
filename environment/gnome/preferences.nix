{ lib, ... }:

{
  dconf.settings = with lib.gvariant; {
    "org/gnome/GWeather4" = {
      temperature-unit = "centigrade";
    };

    "org/gnome/desktop/interface" = {
      clock-format = "12h";
      clock-show-weekday = true;
      enable-animations = true;
      locate-pointer = false;
      overlay-scrolling = true;
      toolbar-style = "text";
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/notifications" = {
      show-banners = true;
      show-in-lock-screen = false;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = true;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/screensaver" = {
      lock-delay = mkUint32 30;
      picture-options = "zoom";
    };

    "org/gnome/desktop/wm/preferences" = {
      action-middle-click-titlebar = "lower";
      action-right-click-titlebar = "menu";
      auto-raise = false;
      button-layout = "icon:minimize,maximize,close";
      focus-mode = "click";
      num-workspaces = 6;
      resize-with-right-button = true;
    };

    "org/gnome/mutter" = {
      auto-maximize = false;
      attach-modal-dialogs = false;
      center-new-windows = true;
      dynamic-workspaces = true;
      edge-tiling = false;
      focus-change-on-pointer-rest = true;
    };

    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "suspend";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      favorite-apps = [
        "kitty.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Geary.desktop"
        "brave-browser.desktop"
        "android-studio.desktop"
        "android-studio-dev.desktop"
        "android-studio-beta.desktop"
      ];
    };
  };
}

{ lib, config, pkgs, ... }: let

  pop-shell-no-icon = pkgs.gnomeExtensions.pop-shell.overrideAttrs (oldAttrs: {
    postInstall = ''
      ${oldAttrs.postInstall or ""}
      substituteInPlace $out/share/gnome-shell/extensions/pop-shell@system76.com/extension.js \
        --replace-fail "panel.addToStatusArea('pop-shell', indicator.button);" \
        "// panel.addToStatusArea('pop-shell', indicator.button);"
    '';
  });

  gnomeExtensionsList = with pkgs.gnomeExtensions; [
    blur-my-shell
    vitals
    just-perfection
    clipboard-history
    pop-shell-no-icon
    tailscale-qs
    status-area-horizontal-spacing
    unite
    user-themes
  ];

in {
  home.packages = gnomeExtensionsList;

  dconf.settings = with lib.gvariant; {
    "org/gnome/shell" = {
      enabled-extensions = (map (extension: extension.extensionUuid) gnomeExtensionsList);
    };

    "org/gnome/shell/extensions/pop-shell" =
      let
        hintColor = x: config.lib.stylix.colors."base03-rgb-${x}";
        toRGBA = color: "rgba(${color "r"}, ${color "g"}, ${color "b"}, 1)";
      in
      {
        tile-by-default = true;
        active-hint = true;
        active-hint-border-radius = mkUint32 2; # In pixels (0-30)
        hint-color-rgba = toRGBA hintColor;
        gap-inner = 2;
        gap-outer = 2;

        fullscreen-launcher = true; # Allow showing launcher above fullscreen windows
        show-title = false; # Show title bars on windows with server-side decorations
        show-skip-taskbar = true; # Handle minimized to tray windows
        mouse-cursor-follows-active-window = true; # Move cursor to active window when navigating with keyboard shortcuts or touchpad gestures
        mouse-cursor-focus-location = 0; # The location the mouse cursor focuses when selecting a window
        smart-gaps = false; # Hide the outer gap when a tree contains only one window
        snap-to-grid = false; # Snaps windows to the tiling grid on drop
        stacking-with-mouse = true; # Allow for stacking windows as a result of dragging a window with mouse
        log-level = 0; # Log level: 0 - OFF  1 - ERROR  2 - WARN  3 - INFO  4 - DEBUG

        activate-launcher = [ "<Super>space" ];
        toggle-stacking = [ "s" ]; # Toggle stacking mode inside management mode
        toggle-stacking-global = [ "<Super>s" ]; # Toggle stacking mode outside management mode
        management-orientation = [ "o" ]; # Toggle tiling orientation inside management mode
        tile-orientation = [ "<Super>o" ]; # Toggle tiling orientation outside management mode
        toggle-floating = [ "<Super>g" ]; # Toggles a window between floating and tiling
        toggle-tiling = [ "<Super>y" ]; # Toggles auto-tiling on and off

        tile-enter = [ "<Super>Return" ]; # Enter tiling management mode
        tile-accept = [ "Return" ]; # Accept tiling changes
        tile-reject = [ "Escape" ]; # Reject tiling changes
        tile-move-left = [ "Left" "h" ]; # Move window left
        tile-move-down = [ "Down" "j" ]; # Move window down
        tile-move-up = [ "Up" "k" ]; # Move window up
        tile-move-right = [ "Right" "l" ]; # Move window right
        tile-resize-left = [ "<Shift>Left" "<Shift>h" ]; # Resize window left
        tile-resize-down = [ "<Shift>Down" "<Shift>j" ]; # Resize window down
        tile-resize-up = [ "<Shift>Up" "<Shift>k" ]; # Resize window up
        tile-resize-right = [ "<Shift>Right" "<Shift>l" ]; # Resize window right
        tile-swap-left = [ "<Ctrl>Left" "<Ctrl>h" ]; # Swap window left
        tile-swap-down = [ "<Ctrl>Down" "<Ctrl>j" ]; # Swap window down
        tile-swap-up = [ "<Ctrl>Up" "<Ctrl>k" ]; # Swap window up
        tile-swap-right = [ "<Ctrl>Right" "<Ctrl>l" ]; # Swap window right

        focus-left = [ "<Super>Left" "<Super>h" ];
        focus-down = [ "<Super>Down" "<Super>j" ];
        focus-up = [ "<Super>Up" "<Super>k" ];
        focus-right = [ "<Super>Right" "<Super>l" ];

        tile-move-left-global = [ ]; # Move window left (global)
        tile-move-down-global = [ ]; # Move window down (global)
        tile-move-up-global = [ ]; # Move window up (global)
        tile-move-right-global = [ ]; # Move window right (global)

        pop-workspace-down = [ ];
        pop-workspace-up = [ ];
        pop-monitor-down = [ ];
        pop-monitor-up = [ ];
        pop-monitor-left = [ ];
        pop-monitor-right = [ ];
      };

    "org/gnome/shell/extensions/blur-my-shell" = {
      hacks-level = 1;
      settings-version = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.40;
      sigma = 40;
      style-dialogs = 0;
    };

    "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      pipeline = "pipeline_default";
      style-components = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = true;
      brightness = 0.2;
      force-light-text = false;
      override-background = true;
      override-background-dynamically = false;
      sigma = 20;
      static-blur = false;
      style-panel = 0;
      unblur-in-overview = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/screenshot" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      blur = true;
      blur-on-overview = false;
      brightness = 0.80;
      dynamic-opacity = false;
      opacity = 220;
      sigma = 24;
      whitelist = [ "kitty" ];
    };

    "org/gnome/shell/extensions/just-perfection" = {
      activities-button = true;
      alt-tab-small-icon-size = 0;
      alt-tab-window-preview-size = 0;
      animation = 4;
      background-menu = true;
      calendar = true;
      clock-menu = true;
      clock-menu-position = 0;
      clock-menu-position-offset = 0;
      controls-manager-spacing-size = 0;
      dash = true;
      dash-icon-size = 0;
      double-super-to-appgrid = true;
      keyboard-layout = true;
      osd = true;
      overlay-key = true;
      panel = true;
      panel-button-padding-size = 0;
      panel-icon-size = 14;
      panel-in-overview = true;
      panel-indicator-padding-size = 0;
      panel-notification-icon = true;
      panel-size = 32;
      power-icon = true;
      quick-settings = true;
      ripple-box = true;
      search = true;
      show-apps-button = true;
      startup-status = 0;
      switcher-popup-delay = true;
      theme = true;
      top-panel-position = 0;
      weather = false;
      window-demands-attention-focus = false;
      window-maximized-on-create = false;
      window-picker-icon = true;
      window-preview-caption = true;
      window-preview-close-button = true;
      workspace = true;
      workspace-background-corner-size = 0;
      workspace-peek = true;
      workspace-popup = true;
      workspace-switcher-should-show = false;
      workspace-switcher-size = 0;
      workspace-wrap-around = true;
      workspaces-in-app-grid = true;
      world-clock = false;
    };

    "org/gnome/shell/extensions/vitals" = {
      alphabetize = false;
      hide-icons = false;
      hide-zeros = false;
      hot-sensors = [ "_memory_usage_" "_temperature_processor_0_" "_storage_used_" ];
      icon-style = 0;
      menu-centered = true;
      position-in-panel = 1;
      show-fan = false;
      show-gpu = false;
      show-voltage = false;
    };

    "org/gnome/shell/extensions/clipboard-history" = {
      cache-size = 50;
      disable-down-arrow = true;
      display-mode = 0;
      history-size = 500;
      notify-on-copy = true;
      window-width-percentage = 25;
    };

    "org/gnome/shell/extensions/status-area-horizontal-spacing" = {
      hpadding = 3;
    };

    "org/gnome/shell/extensions/unite" = {
      autofocus-windows = true;
      desktop-name-text = "Desktop";
      enable-titlebar-actions = false;
      extend-left-box = false;
      greyscale-tray-icons = false;
      hide-activities-button = "never";
      hide-app-menu-icon = true;
      hide-window-titlebars = "always";
      reduce-panel-spacing = false;
      show-appmenu-button = false;
      show-desktop-name = false;
      show-window-buttons = "never";
      show-window-title = "never";
      use-activities-text = false;
    };
  };
}

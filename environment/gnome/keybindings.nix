{ lib, ... }: {
  dconf.settings = with lib.gvariant; {
    "org/gnome/desktop/wm/keybindings" = {
      switch-to-workspace-1 = [ "<Super><Ctrl>semicolon" ];
      switch-to-workspace-2 = [ "<Super><Ctrl>n" ];
      switch-to-workspace-3 = [ "<Super><Ctrl>m" ];
      switch-to-workspace-4 = [ "<Super><Ctrl>comma" ];
      switch-to-workspace-5 = [ "<Super><Ctrl>period" ];
      switch-to-workspace-6 = [ "<Super><Ctrl>slash" ];
      switch-to-workspace-7 = [ ];
      switch-to-workspace-8 = [ ];
      switch-to-workspace-9 = [ ];
      switch-to-workspace-10 = [ ];
      switch-to-workspace-11 = [ ];
      switch-to-workspace-12 = [ ];
      switch-to-workspace-left = [ "<Super><Ctrl>h" "<Super><Ctrl>Left" ];
      switch-to-workspace-right = [ "<Super><Ctrl>l" "<Super><Ctrl>Right" ];
      switch-to-workspace-up = [ "<Super><Ctrl>k" "<Super><Ctrl>Up" ];
      switch-to-workspace-down = [ "<Super><Ctrl>j" "<Super><Ctrl>Down" ];
      switch-to-workspace-last = [ ];

      move-to-workspace-1 = [ "<Super><Shift>semicolon" ];
      move-to-workspace-2 = [ "<Super><Shift>n" ];
      move-to-workspace-3 = [ "<Super><Shift>m" ];
      move-to-workspace-4 = [ "<Super><Shift>comma" ];
      move-to-workspace-5 = [ "<Super><Shift>period" ];
      move-to-workspace-6 = [ "<Super><Shift>slash" ];
      move-to-workspace-7 = [ ];
      move-to-workspace-8 = [ ];
      move-to-workspace-9 = [ ];
      move-to-workspace-10 = [ ];
      move-to-workspace-11 = [ ];
      move-to-workspace-12 = [ ];
      move-to-workspace-last = [ ];
      move-to-workspace-left = [ "<Super><Shift>h" "<Super><Shift>Left" ];
      move-to-workspace-right = [ "<Super><Shift>l" "<Super><Shift>Right" ];
      move-to-workspace-up = [ "<Super><Shift>k" "<Super><Shift>Up" ];
      move-to-workspace-down = [ "<Super><Shift>j" "<Super><Shift>Down" ];
      move-to-monitor-left = [ "<Super><Shift><Alt>Left" ];
      move-to-monitor-right = [ "<Super><Shift><Alt>Right" ];
      move-to-monitor-up = [ "<Super><Shift><Alt>Up" ];
      move-to-monitor-down = [ "<Super><Shift><Alt>Down" ];

      move-to-corner-nw = [ ]; # Move window to top left corner
      move-to-corner-ne = [ ]; # Move window to top right corner
      move-to-corner-sw = [ ]; # Move window to bottom left corner
      move-to-corner-se = [ ]; # Move window to bottom right corner
      move-to-side-n = [ ]; # Move window to top edge of screen
      move-to-side-s = [ ]; # Move window to bottom edge of screen
      move-to-side-e = [ ]; # Move window to right side of screen
      move-to-side-w = [ ]; # Move window to left side of screen
      move-to-center = [ ]; # Move window to center of screen

      switch-group = [ "<Alt>Above_Tab" ]; # Switch windows of an application
      switch-group-backward = [ ]; # Reverse switch windows of an application
      switch-applications = [ "<Alt>Tab" ]; # Switch applications
      switch-applications-backward = [ ]; # Reverse switch applications
      switch-windows = [ ]; # Switch windows
      switch-windows-backward = [ ]; # Reverse switch windows
      switch-panels = [ "<Ctrl><Alt>Tab" ]; # Switch system Ctrls
      switch-panels-backward = [ ]; # Reverse switch system Ctrls

      cycle-group = [ ]; # Switch windows of an app directly
      cycle-group-backward = [ ]; # Reverse switch windows of an app directly
      cycle-windows = [ "<Super>Tab" ]; # Switch windows directly
      cycle-windows-backward = [ ]; # Reverse switch windows directly
      cycle-panels = [ ]; # Switch system Ctrls directly
      cycle-panels-backward = [ ]; # Reverse switch system Ctrls directly

      show-desktop = [ "<Super>d" ]; # Hide all normal windows
      panel-run-dialog = [ ]; # Show the run command prompt

      activate-window-menu = [ "<Alt>space" ];
      close = [ "<Alt>F4" "<Super>c" ];
      minimize = [ "<Alt>F9" ];
      maximize = [ ];
      unmaximize = [ ];
      maximize-vertically = [ ];
      maximize-horizontally = [ ];
      toggle-maximized = [ ];
      toggle-fullscreen = [ "<Alt>F11" ];
      toggle-above = [ "<Alt>F12" ]; # Toggle window always appearing on top
      always-on-top = [ ]; # Toggle window to be always on top, idk why there are two
      toggle-on-all-workspaces = [ "<Alt>F6" ];
      begin-move = [ "<Alt>F7" ];
      begin-resize = [ "<Alt>F8" ];
      raise-or-lower = [ "<Alt>F5" ];
      raise = [ ];
      lower = [ ];

      switch-input-source = [ "<Super><Alt>space" "XF86Keyboard" ];
      switch-input-source-backward = [ "<Shift><Super><Alt>space" "<Shift>XF86Keyboard" ];
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ ];
      toggle-tiled-right = [ ];
    };

    "org/gnome/shell/keybindings" = {
      focus-active-notification = [ ];
      open-new-window-application-1 = [ "<Super><Ctrl>1" ];
      open-new-window-application-2 = [ "<Super><Ctrl>2" ];
      open-new-window-application-3 = [ "<Super><Ctrl>3" ];
      open-new-window-application-4 = [ "<Super><Ctrl>4" ];
      open-new-window-application-5 = [ "<Super><Ctrl>5" ];
      open-new-window-application-6 = [ "<Super><Ctrl>6" ];
      open-new-window-application-7 = [ "<Super><Ctrl>7" ];
      open-new-window-application-8 = [ "<Super><Ctrl>8" ];
      open-new-window-application-9 = [ "<Super><Ctrl>9" ];

      switch-to-application-1 = [ "<Super>1" ];
      switch-to-application-2 = [ "<Super>2" ];
      switch-to-application-3 = [ "<Super>3" ];
      switch-to-application-4 = [ "<Super>4" ];
      switch-to-application-5 = [ "<Super>5" ];
      switch-to-application-6 = [ "<Super>6" ];
      switch-to-application-7 = [ "<Super>7" ];
      switch-to-application-8 = [ "<Super>8" ];
      switch-to-application-9 = [ "<Super>9" ];

      screenshot = [ "<Shift>Print" ];
      screenshot-window = [ "<Alt>Print" ];
      shift-overview-down = [ "<Super><Alt>Down" ];
      shift-overview-up = [ "<Super><Alt>Up" ];
      show-screen-recording-ui = [ "<Ctrl><Shift><Alt>R" ];
      show-screenshot-ui = [ "Print" "<Super><Shift>s" ];

      toggle-application-view = [ "<Super>a" ];
      toggle-message-tray = [ "<Alt>F3" ];
      toggle-overview = [ ];
      toggle-quick-settings = [ "<Super><Alt>s" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = [ "<Super><Alt>l" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>b";
      command = "brave";
      name = "Launch Browser";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Super>t";
      command = "kitty";
      name = "Launch Terminal";
    };
  };
}

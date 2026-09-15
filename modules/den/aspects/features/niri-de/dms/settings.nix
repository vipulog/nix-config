{
  den.aspects.niri-de.dms.settings = {
    homeManager = {
      programs.dank-material-shell = {
        settings = {
          currentThemeCategory = "dynamic";
          currentThemeName = "dynamic";
          matugenScheme = "scheme-content";
          gtkThemingEnabled = true;

          blurEnabled = true;
          cornerRadius = 8;
          launcherLogoMode = "os";
          clockCompactMode = true;
          niriLayoutGapsOverride = 8;
          osdPowerProfileEnabled = true;
          popupTransparency = 1;
          terminalsAlwaysDark = true;
          updaterHideWidget = true;
          useAutoLocation = true;

          lockBeforeSuspend = true;
          lockScreenPowerOffMonitorsOnLock = true;
          lockScreenShowDate = false;
          lockScreenShowPowerActions = false;
          lockScreenShowSystemIcons = false;
          lockScreenShowTime = false;

          notificationCompactMode = true;
          notificationOverlayEnabled = true;
          notificationPopupPosition = 1;

          cursorSettings = {
            size = 24;

            niri = {
              hideAfterInactiveMs = 0;
              hideWhenTyping = true;
            };
          };

          barConfigs = [
            {
              enabled = true;
              visible = true;
              id = "default";
              name = "Main Bar";

              position = 2;
              spacing = 0;
              transparency = 0.9;
              fontScale = 0.8;
              innerPadding = 2;
              squareCorners = true;
              openOnOverview = true;

              borderEnabled = true;
              borderOpacity = 0.1;

              widgetOutlineColor = "surfaceText";
              widgetOutlineEnabled = true;
              widgetOutlineOpacity = 0.1;
              widgetPadding = 4;

              centerWidgets = [
                "music"
                "clock"
                "weather"
              ];

              leftWidgets = [
                "launcherButton"
                "workspaceSwitcher"
                "focusedWindow"
              ];

              rightWidgets = [
                "systemTray"
                "cpuUsage"
                "memUsage"
                "notificationButton"
                "battery"
                "controlCenterButton"
              ];
            }
          ];
        };

        clipboardSettings = {
          maxHistory = 100;
          maxEntrySize = 5242880;
          autoClearDays = 0;
          clearAtStartup = false;
          disabled = false;
          maxPinned = 25;
        };
      };
    };
  };
}

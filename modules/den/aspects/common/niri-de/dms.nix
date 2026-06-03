{inputs, ...}: {
  flake-file.inputs = {
    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.niri-de = {
    homeManager = {lib, ...}: {
      imports = [
        inputs.dms.homeModules.dank-material-shell
        inputs.dms.homeModules.niri
      ];

      programs.dank-material-shell = {
        enable = true;
        enableVPN = true;
        enableCalendarEvents = true;
        enableClipboardPaste = true;
        enableDynamicTheming = true;
        enableAudioWavelength = true;
        enableSystemMonitoring = true;

        systemd = {
          enable = true;
          restartIfChanged = true;
        };

        settings = {
          matugenScheme = "scheme-content";
          popupTransparency = 0.9;
          cornerRadius = 6;
          currentThemeCategory = "dynamic";
          currentThemeName = "dynamic";
          niriLayoutGapsOverride = 6;
          blurEnabled = true;
          blurWallpaperOnOverview = true;
          useAutoLocation = true;
          launcherLogoMode = "os";
          lockBeforeSuspend = true;
          terminalsAlwaysDark = true;
          notificationOverlayEnabled = true;
          notificationPopupPrivacyMode = true;
          lockScreenShowPowerActions = false;
          lockScreenShowSystemIcons = false;
          lockScreenShowTime = false;
          lockScreenShowDate = false;
          lockScreenPowerOffMonitorsOnLock = true;
          notificationPopupPosition = 1;
          osdPowerProfileEnabled = true;
          updaterHideWidget = true;

          cursorSettings = {
            theme = "System Default";
            size = 18;

            hyprland = {
              hideOnKeyPress = false;
              hideOnTouch = false;
              inactiveTimeout = 0;
            };

            dwl = {
              cursorHideTimeout = 0;
            };

            niri = {
              hideWhenTyping = true;
              hideAfterInactiveMs = 0;
            };
          };

          barConfigs = [
            {
              id = "default";
              name = "Main Bar";
              enabled = true;

              position = 2;
              spacing = 0;
              transparency = 0.9;
              squareCorners = true;
              gothCornersEnabled = true;
              borderEnabled = true;
              borderOpacity = 0.1;
              widgetOutlineEnabled = true;
              widgetOutlineColor = "surfaceText";
              widgetOutlineOpacity = 0.1;
              openOnOverview = true;
              shadowOpacity = 50;
              shadowColorMode = "surface";

              screenPreferences = ["all"];
              showOnLastDisplay = true;

              leftWidgets = [
                "launcherButton"
                "workspaceSwitcher"
                "focusedWindow"
              ];

              centerWidgets = [
                "music"
                "clock"
                "weather"
              ];

              rightWidgets = [
                "systemTray"
                "clipboard"
                "cpuUsage"
                "memUsage"
                "notificationButton"
                "battery"
                "controlCenterButton"
              ];

              innerPadding = 4;
              bottomGap = 0;
              widgetTransparency = 1;
              noBackground = false;
              maximizeWidgetIcons = false;
              maximizeWidgetText = false;
              removeWidgetPadding = false;
              widgetPadding = 8;
              gothCornerRadiusOverride = false;
              gothCornerRadiusValue = 12;
              borderColor = "surfaceText";
              borderThickness = 1;
              widgetOutlineThickness = 1;
              fontScale = 1;
              iconScale = 1;
              autoHide = false;
              autoHideStrict = false;
              autoHideDelay = 250;
              showOnWindowsOpen = false;
              visible = true;
              popupGapsAuto = true;
              popupGapsManual = 4;
              maximizeDetection = true;
              useOverlayLayer = false;
              scrollEnabled = true;
              scrollXBehavior = "column";
              scrollYBehavior = "workspace";
              shadowIntensity = 0;
              shadowCustomColor = "#000000";
              clickThrough = false;
            }
          ];

          customThemeFile = "";
          registryThemeVariants = {};
          matugenContrast = 0;
          runUserMatugenTemplates = true;
          matugenTargetMonitor = "";
          dockTransparency = 1;
          widgetBackgroundColor = "sch";
          widgetColorMode = "default";
          controlCenterTileColorMode = "primary";
          buttonColorMode = "primary";
          niriLayoutRadiusOverride = -1;
          niriLayoutBorderSize = -1;
          hyprlandLayoutGapsOverride = -1;
          hyprlandLayoutRadiusOverride = -1;
          hyprlandLayoutBorderSize = -1;
          mangoLayoutGapsOverride = -1;
          mangoLayoutRadiusOverride = -1;
          mangoLayoutBorderSize = -1;
          firstDayOfWeek = -1;
          showWeekNumber = false;
          use24HourClock = true;
          showSeconds = false;
          padHours12Hour = false;
          useFahrenheit = false;
          windSpeedUnit = "kmh";
          nightModeEnabled = false;
          animationSpeed = 1;
          customAnimationDuration = 500;
          syncComponentAnimationSpeeds = true;
          popoutAnimationSpeed = 1;
          popoutCustomAnimationDuration = 150;
          modalAnimationSpeed = 1;
          modalCustomAnimationDuration = 150;
          enableRippleEffects = true;
          animationVariant = 0;
          motionEffect = 0;
          m3ElevationEnabled = true;
          m3ElevationIntensity = 12;
          m3ElevationOpacity = 30;
          m3ElevationColorMode = "default";
          m3ElevationLightDirection = "top";
          m3ElevationCustomColor = "#000000";
          modalElevationEnabled = true;
          popoutElevationEnabled = true;
          barElevationEnabled = true;
          blurForegroundLayers = true;
          blurLayerOutlineOpacity = 0.12;
          blurBorderColor = "outline";
          blurBorderCustomColor = "#ffffff";
          blurBorderOpacity = 0.35;
          wallpaperFillMode = "Fill";
          blurredWallpaperLayer = false;
          showLauncherButton = true;
          showWorkspaceSwitcher = true;
          showFocusedWindow = true;
          showWeather = true;
          showMusic = true;
          showClipboard = true;
          showCpuUsage = true;
          showMemUsage = true;
          showCpuTemp = true;
          showGpuTemp = true;
          selectedGpuIndex = 0;
          enabledGpuPciIds = [];
          showSystemTray = true;
          systemTrayIconTintMode = "none";
          systemTrayIconTintSaturation = 50;
          systemTrayIconTintStrength = 135;
          showClock = true;
          showNotificationButton = true;
          showBattery = true;
          showControlCenterButton = true;
          showCapsLockIndicator = true;
          controlCenterShowNetworkIcon = true;
          controlCenterShowBluetoothIcon = true;
          controlCenterShowAudioIcon = true;
          controlCenterShowAudioPercent = false;
          controlCenterShowVpnIcon = true;
          controlCenterShowBrightnessIcon = false;
          controlCenterShowBrightnessPercent = false;
          controlCenterShowMicIcon = false;
          controlCenterShowMicPercent = false;
          controlCenterShowBatteryIcon = false;
          controlCenterShowPrinterIcon = false;
          controlCenterShowScreenSharingIcon = true;
          showPrivacyButton = true;
          privacyShowMicIcon = false;
          privacyShowCameraIcon = false;
          privacyShowScreenShareIcon = false;

          controlCenterWidgets = [
            {
              id = "volumeSlider";
              enabled = true;
              width = 50;
            }
            {
              id = "brightnessSlider";
              enabled = true;
              width = 50;
            }
            {
              id = "wifi";
              enabled = true;
              width = 50;
            }
            {
              id = "bluetooth";
              enabled = true;
              width = 50;
            }
            {
              id = "audioOutput";
              enabled = true;
              width = 50;
            }
            {
              id = "audioInput";
              enabled = true;
              width = 50;
            }
            {
              id = "nightMode";
              enabled = true;
              width = 50;
            }
            {
              id = "darkMode";
              enabled = true;
              width = 50;
            }
          ];

          showWorkspaceIndex = false;
          showWorkspaceName = false;
          showWorkspacePadding = false;
          workspaceScrolling = false;
          showWorkspaceApps = false;
          workspaceDragReorder = true;
          maxWorkspaceIcons = 3;
          workspaceAppIconSizeOffset = 0;
          groupWorkspaceApps = true;
          workspaceFollowFocus = false;
          showOccupiedWorkspacesOnly = false;
          reverseScrolling = false;
          dwlShowAllTags = false;
          workspaceActiveAppHighlightEnabled = false;
          workspaceColorMode = "default";
          workspaceOccupiedColorMode = "none";
          workspaceUnfocusedColorMode = "default";
          workspaceUrgentColorMode = "default";
          workspaceFocusedBorderEnabled = false;
          workspaceFocusedBorderColor = "primary";
          workspaceFocusedBorderThickness = 2;
          workspaceNameIcons = {};
          waveProgressEnabled = true;
          scrollTitleEnabled = true;
          mediaAdaptiveWidthEnabled = true;
          audioVisualizerEnabled = true;
          audioScrollMode = "volume";
          audioWheelScrollAmount = 5;
          clockCompactMode = false;
          focusedWindowCompactMode = false;
          focusedWindowSize = 1;
          runningAppsCompactMode = true;
          barMaxVisibleApps = 0;
          barMaxVisibleRunningApps = 0;
          barShowOverflowBadge = true;
          appsDockHideIndicators = false;
          appsDockColorizeActive = false;
          appsDockActiveColorMode = "primary";
          appsDockEnlargeOnHover = false;
          appsDockEnlargePercentage = 125;
          appsDockIconSizePercentage = 100;
          keyboardLayoutNameCompactMode = false;
          runningAppsCurrentWorkspace = true;
          runningAppsGroupByApp = false;
          runningAppsCurrentMonitor = false;

          appIdSubstitutions = [
            {
              pattern = "Spotify";
              replacement = "spotify";
              type = "exact";
            }
            {
              pattern = "beepertexts";
              replacement = "beeper";
              type = "exact";
            }
            {
              pattern = "home assistant desktop";
              replacement = "homeassistant-desktop";
              type = "exact";
            }
            {
              pattern = "com.transmissionbt.transmission";
              replacement = "transmission-gtk";
              type = "contains";
            }
            {
              pattern = "^steam_app_(\\d+)$";
              replacement = "steam_icon_$1";
              type = "regex";
            }
          ];

          centeringMode = "index";
          clockDateFormat = "";
          lockDateFormat = "";
          greeterRememberLastSession = true;
          greeterRememberLastUser = true;
          greeterEnableFprint = false;
          greeterEnableU2f = false;
          greeterWallpaperPath = "";
          greeterUse24HourClock = true;
          greeterShowSeconds = false;
          greeterPadHours12Hour = false;
          greeterLockDateFormat = "";
          greeterFontFamily = "";
          greeterWallpaperFillMode = "";
          mediaSize = 1;
          appLauncherViewMode = "list";
          spotlightModalViewMode = "list";
          browserPickerViewMode = "grid";
          browserUsageHistory = {};
          appPickerViewMode = "grid";
          filePickerUsageHistory = {};
          sortAppsAlphabetically = false;
          appLauncherGridColumns = 4;
          spotlightCloseNiriOverview = true;
          rememberLastQuery = false;
          rememberLastMode = true;
          spotlightSectionViewModes = {};
          appDrawerSectionViewModes = {};
          niriOverviewOverlayEnabled = true;
          dankLauncherV2Size = "compact";
          dankLauncherV2BorderEnabled = false;
          dankLauncherV2BorderThickness = 2;
          dankLauncherV2BorderColor = "primary";
          dankLauncherV2ShowFooter = true;
          dankLauncherV2UnloadOnClose = false;
          dankLauncherV2IncludeFilesInAll = false;
          dankLauncherV2IncludeFoldersInAll = false;
          launcherUseOverlayLayer = false;
          launcherStyle = "full";
          spotlightBarShowModeChips = false;
          weatherEnabled = true;
          networkPreference = "auto";
          iconTheme = "System Default";
          availableIconThemes = ["System Default"];
          systemDefaultIconTheme = "";
          qt5ctAvailable = false;
          qt6ctAvailable = false;
          gtkAvailable = false;

          availableCursorThemes = ["System Default"];
          systemDefaultCursorTheme = "";
          launcherLogoCustomPath = "";
          launcherLogoColorOverride = "";
          launcherLogoColorInvertOnMode = false;
          launcherLogoBrightness = 0.5;
          launcherLogoContrast = 1;
          launcherLogoSizeOffset = 0;
          fontFamily = "Inter Variable";
          monoFontFamily = "Fira Code";
          fontWeight = 400;
          fontScale = 1;
          textRenderType = 0;
          textRenderQuality = 0;
          notepadUseMonospace = true;
          notepadFontFamily = "";
          notepadFontSize = 14;
          notepadShowLineNumbers = false;
          notepadTransparencyOverride = -1;
          notepadLastCustomTransparency = 0.7;
          soundsEnabled = true;
          useSystemSoundTheme = false;
          soundLogin = false;
          soundNewNotification = true;
          soundVolumeChanged = true;
          soundPluggedIn = true;
          acMonitorTimeout = 0;
          acLockTimeout = 0;
          acSuspendTimeout = 0;
          acSuspendBehavior = 0;
          acProfileName = "";
          acPostLockMonitorTimeout = 0;
          batteryMonitorTimeout = 0;
          batteryLockTimeout = 0;
          batterySuspendTimeout = 0;
          batterySuspendBehavior = 0;
          batteryProfileName = "";
          batteryPostLockMonitorTimeout = 0;
          batteryChargeLimit = 100;
          loginctlLockIntegration = true;
          fadeToLockEnabled = true;
          fadeToLockGracePeriod = 5;
          fadeToDpmsEnabled = true;
          fadeToDpmsGracePeriod = 5;
          launchPrefix = "";
          brightnessDevicePins = {};
          wifiNetworkPins = {};
          bluetoothDevicePins = {};
          audioInputDevicePins = {};
          audioOutputDevicePins = {};
          gtkThemingEnabled = false;
          qtThemingEnabled = false;
          syncModeWithPortal = true;
          muxType = "tmux";
          muxUseCustomCommand = false;
          muxCustomCommand = "";
          muxSessionFilter = "";
          runDmsMatugenTemplates = true;
          matugenTemplateGtk = true;
          matugenTemplateNiri = true;
          matugenTemplateHyprland = true;
          matugenTemplateMangowc = true;
          matugenTemplateQt5ct = true;
          matugenTemplateQt6ct = true;
          matugenTemplateFirefox = true;
          matugenTemplatePywalfox = true;
          matugenTemplateZenBrowser = true;
          matugenTemplateVesktop = true;
          matugenTemplateVencord = true;
          matugenTemplateEquibop = true;
          matugenTemplateGhostty = true;
          matugenTemplateKitty = true;
          matugenTemplateFoot = true;
          matugenTemplateAlacritty = true;
          matugenTemplateNeovim = false;
          matugenTemplateWezterm = true;
          matugenTemplateDgop = true;
          matugenTemplateKcolorscheme = true;
          matugenTemplateVscode = true;
          matugenTemplateEmacs = true;
          matugenTemplateZed = true;

          matugenTemplateNeovimSettings = {
            dark = {
              baseTheme = "github_dark";
              harmony = 0.5;
            };

            light = {
              baseTheme = "github_light";
              harmony = 0.5;
            };
          };

          matugenTemplateNeovimSetBackground = true;
          showDock = false;
          dockAutoHide = false;
          dockSmartAutoHide = false;
          dockUseOverlayLayer = false;
          dockGroupByApp = false;
          dockRestoreSpecialWorkspaceOnClick = false;
          dockOpenOnOverview = false;
          dockPosition = 1;
          dockSpacing = 4;
          dockBottomGap = 0;
          dockMargin = 0;
          dockIconSize = 40;
          dockIndicatorStyle = "circle";
          dockBorderEnabled = false;
          dockBorderColor = "surfaceText";
          dockBorderOpacity = 1;
          dockBorderThickness = 1;
          dockIsolateDisplays = false;
          dockLauncherEnabled = false;
          dockLauncherLogoMode = "apps";
          dockLauncherLogoCustomPath = "";
          dockLauncherLogoColorOverride = "";
          dockLauncherLogoSizeOffset = 0;
          dockLauncherLogoBrightness = 0.5;
          dockLauncherLogoContrast = 1;
          dockMaxVisibleApps = 0;
          dockMaxVisibleRunningApps = 0;
          dockShowOverflowBadge = true;
          dockShowTrash = false;
          dockTrashFileManager = "default";
          dockTrashCustomCommand = "";
          notificationPopupShadowEnabled = true;
          overviewRows = 2;
          overviewColumns = 5;
          overviewScale = 0.16;
          modalDarkenBackground = true;
          lockScreenShowProfileImage = true;
          lockScreenShowPasswordField = true;
          lockScreenShowMediaPlayer = true;
          lockAtStartup = false;
          enableFprint = false;
          maxFprintTries = 15;
          enableU2f = false;
          u2fMode = "or";
          lockScreenActiveMonitor = "all";
          lockScreenInactiveColor = "#000000";
          lockScreenNotificationMode = 0;
          lockScreenVideoEnabled = false;
          lockScreenVideoPath = "";
          lockScreenVideoCycling = false;
          hideBrightnessSlider = false;
          notificationTimeoutLow = 5000;
          notificationTimeoutNormal = 5000;
          notificationTimeoutCritical = 0;
          notificationCompactMode = false;
          notificationDedupeEnabled = true;
          notificationAnimationSpeed = 1;
          notificationCustomAnimationDuration = 400;
          notificationHistoryEnabled = true;
          notificationHistoryMaxCount = 50;
          notificationHistoryMaxAgeDays = 7;
          notificationHistorySaveLow = true;
          notificationHistorySaveNormal = true;
          notificationHistorySaveCritical = true;
          notificationRules = [];
          notificationFocusedMonitor = false;
          osdAlwaysShowValue = false;
          osdPosition = 5;
          osdVolumeEnabled = true;
          osdMediaVolumeEnabled = true;
          osdMediaPlaybackEnabled = false;
          osdBrightnessEnabled = true;
          osdIdleInhibitorEnabled = true;
          osdMicMuteEnabled = true;
          osdCapsLockEnabled = true;
          osdAudioOutputEnabled = true;
          powerActionConfirm = true;
          powerActionHoldDuration = 0.5;

          powerMenuActions = [
            "reboot"
            "logout"
            "poweroff"
            "lock"
            "suspend"
            "restart"
          ];

          powerMenuDefaultAction = "logout";
          powerMenuGridLayout = false;
          customPowerActionLock = "";
          customPowerActionLogout = "";
          customPowerActionSuspend = "";
          customPowerActionHibernate = "";
          customPowerActionReboot = "";
          customPowerActionPowerOff = "";
          updaterCheckOnStart = false;
          updaterUseCustomCommand = false;
          updaterCustomCommand = "";
          updaterTerminalAdditionalParams = "";
          updaterIntervalSeconds = 1800;
          updaterIncludeFlatpak = true;
          updaterAllowAUR = true;
          displayNameMode = "system";
          screenPreferences = {};
          showOnLastDisplay = {};
          niriOutputSettings = {};
          hyprlandOutputSettings = {};
          displayProfiles = {};
          activeDisplayProfile = {};
          displayProfileAutoSelect = false;
          displayShowDisconnected = false;
          displaySnapToEdge = true;
          connectedFrameBarStyleBackups = {};
          desktopClockEnabled = false;
          desktopClockStyle = "analog";
          desktopClockTransparency = 0.8;
          desktopClockColorMode = "primary";
          desktopClockCustomColor = "#ffffff";
          desktopClockShowDate = true;
          desktopClockShowAnalogNumbers = false;
          desktopClockShowAnalogSeconds = true;
          desktopClockX = -1;
          desktopClockY = -1;
          desktopClockWidth = 280;
          desktopClockHeight = 180;
          desktopClockDisplayPreferences = ["all"];
          systemMonitorEnabled = false;
          systemMonitorShowHeader = true;
          systemMonitorTransparency = 0.8;
          systemMonitorColorMode = "primary";
          systemMonitorCustomColor = "#ffffff";
          systemMonitorShowCpu = true;
          systemMonitorShowCpuGraph = true;
          systemMonitorShowCpuTemp = true;
          systemMonitorShowGpuTemp = false;
          systemMonitorGpuPciId = "";
          systemMonitorShowMemory = true;
          systemMonitorShowMemoryGraph = true;
          systemMonitorShowNetwork = true;
          systemMonitorShowNetworkGraph = true;
          systemMonitorShowDisk = true;
          systemMonitorShowTopProcesses = false;
          systemMonitorTopProcessCount = 3;
          systemMonitorTopProcessSortBy = "cpu";
          systemMonitorGraphInterval = 60;
          systemMonitorLayoutMode = "auto";
          systemMonitorX = -1;
          systemMonitorY = -1;
          systemMonitorWidth = 320;
          systemMonitorHeight = 480;
          systemMonitorDisplayPreferences = ["all"];
          systemMonitorVariants = [];
          desktopWidgetPositions = {};
          desktopWidgetGridSettings = {};
          desktopWidgetInstances = [];
          desktopWidgetGroups = [];
          builtInPluginSettings = {};
          clipboardEnterToPaste = false;
          launcherPluginVisibility = {};
          launcherPluginOrder = [];
          frameEnabled = false;
          frameThickness = 16;
          frameRounding = 23;
          frameColor = "";
          frameOpacity = 1;
          frameScreenPreferences = ["all"];
          frameBarSize = 40;
          frameShowOnOverview = false;
          frameBlurEnabled = true;
          frameCloseGaps = true;
          frameLauncherEmergeSide = "bottom";
          frameLauncherArcExtender = false;
          frameMode = "connected";
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

      home.activation.setupDms =
        lib.hm.dag.entryAfter ["writeBoundary"]
        # sh
        ''
          src="${./config/niri/dms}"
          configDir="''${XDG_CONFIG_HOME:-$HOME/.config}/niri/dms"
          mkdir -p "$configDir"

          touch "''${XDG_CONFIG_HOME:-$HOME/.config}/alacritty/dank-theme.toml"

          while IFS= read -r -d $'\0' file; do
            rel="''${file#$src/}"
            if [ ! -e "$configDir/$rel" ]; then
              install -Dm644 "$file" "$configDir/$rel"
            fi
          done < <(find "$src" -type f -print0)
        '';
    };
  };
}

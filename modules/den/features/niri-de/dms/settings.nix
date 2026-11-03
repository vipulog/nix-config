{
  den.aspects.niri-de.dms.settings = {
    homeManager = {
      programs.dank-material-shell = {
        settings = builtins.fromJSON ''
          {
            "lockScreenWidgetInstances": [
              {
                "config": {
                  "autoPosition": true,
                  "colorMode": "default",
                  "customColor": "#ffffff",
                  "displayPreferences": [
                    "all"
                  ],
                  "showAnalogNumbers": false,
                  "showAnalogSeconds": true,
                  "showDate": false,
                  "showDigitalSeconds": false,
                  "style": "overlap",
                  "syncPositionAcrossScreens": true,
                  "transparency": 0,
                  "twoTone": true,
                  "weight": 0
                },
                "enabled": true,
                "id": "lock_clock",
                "widgetType": "desktopClock"
              },
              {
                "config": {
                  "displayPreferences": [
                    "all"
                  ],
                  "passwordVisibility": "always",
                  "profileVisibility": "always",
                  "style": "ring",
                  "syncPositionAcrossScreens": true
                },
                "enabled": true,
                "id": "lock_auth",
                "widgetType": "lockAuth"
              },
              {
                "config": {
                  "displayPreferences": [
                    "all"
                  ],
                  "mode": 2,
                  "syncPositionAcrossScreens": true
                },
                "enabled": false,
                "id": "lock_notifications",
                "widgetType": "lockNotifications"
              },
              {
                "config": {
                  "background": false,
                  "displayPreferences": [
                    "all"
                  ],
                  "showMediaPlayer": false,
                  "showWeather": false,
                  "syncPositionAcrossScreens": true
                },
                "enabled": true,
                "id": "lock_status",
                "widgetType": "lockStatus"
              },
              {
                "config": {
                  "displayPreferences": [
                    "all"
                  ],
                  "shape": "round",
                  "syncPositionAcrossScreens": true
                },
                "enabled": false,
                "id": "lock_power",
                "widgetType": "lockPower"
              },
              {
                "config": {
                  "colorMode": "default",
                  "customColor": "#ffffff",
                  "displayPreferences": [
                    "all"
                  ],
                  "format": "short",
                  "syncPositionAcrossScreens": true
                },
                "enabled": true,
                "id": "lw_1793704622837_vnekvv91t",
                "name": "Date",
                "widgetType": "lockDate"
              }
            ],
            "greeterWidgetInstances": [
              {
                "config": {
                  "autoPosition": true,
                  "colorMode": "default",
                  "customColor": "#ffffff",
                  "displayPreferences": [
                    "all"
                  ],
                  "showAnalogNumbers": false,
                  "showAnalogSeconds": true,
                  "showDate": false,
                  "showDigitalSeconds": false,
                  "style": "overlap",
                  "syncPositionAcrossScreens": true,
                  "transparency": 0,
                  "twoTone": true,
                  "weight": 0
                },
                "enabled": true,
                "id": "lock_clock",
                "widgetType": "desktopClock"
              },
              {
                "config": {
                  "displayPreferences": [
                    "all"
                  ],
                  "passwordVisibility": "always",
                  "profileVisibility": "always",
                  "style": "ring",
                  "syncPositionAcrossScreens": true
                },
                "enabled": true,
                "id": "lock_auth",
                "widgetType": "lockAuth"
              },
              {
                "config": {
                  "background": false,
                  "displayPreferences": [
                    "all"
                  ],
                  "showMediaPlayer": false,
                  "showWeather": false,
                  "syncPositionAcrossScreens": true
                },
                "enabled": true,
                "id": "lock_status",
                "widgetType": "lockStatus"
              },
              {
                "config": {
                  "displayPreferences": [
                    "all"
                  ],
                  "shape": "round",
                  "syncPositionAcrossScreens": true
                },
                "enabled": false,
                "id": "lock_power",
                "widgetType": "lockPower"
              },
              {
                "config": {
                  "colorMode": "default",
                  "customColor": "#ffffff",
                  "displayPreferences": [
                    "all"
                  ],
                  "format": "short",
                  "syncPositionAcrossScreens": true
                },
                "enabled": true,
                "id": "lw_1793704622837_vnekvv91t",
                "name": "Date",
                "widgetType": "lockDate"
              },
              {
                "config": {
                  "displayPreferences": [
                    "all"
                  ],
                  "syncPositionAcrossScreens": true
                },
                "enabled": true,
                "id": "greeter_session",
                "widgetType": "greeterSession"
              }
            ],
            "currentThemeName": "dynamic",
            "radiusStrength": 25,
            "enableRippleEffects": true,
            "scrollbarsEnabled": false,
            "blurBorderEnabled": true,
            "blurBorderOpacity": 0.35,
            "wallpaperFillMode": "Scrolling",
            "wallpaperBackgroundColorMode": "surface",
            "useAutoLocation": true,
            "fontFamily": "Google Sans Flex",
            "fontWeight": 400,
            "fontScale": 1,
            "textRenderType": 0,
            "textRenderQuality": 0,
            "lockScreenShowPowerActions": false,
            "lockScreenShowWeather": false,
            "lockScreenWallpaperFillMode": "Fill",
            "powerMenuActions": [
              "reboot",
              "logout",
              "poweroff",
              "lock",
              "suspend",
              "restart",
              "softreboot",
              "hibernate"
            ],
            "powerMenuDefaultAction": "lock",
            "dockConfigs": [
              {
                "id": "dock",
                "name": "Dock",
                "enabled": true,
                "screenPreferences": [
                  "all"
                ],
                "showOnLastDisplay": true,
                "position": 1,
                "mode": "compact",
                "taskbarAlign": "center",
                "widgetExpansion": "popout",
                "iconSize": 42,
                "spacing": 8,
                "itemSpacing": 8,
                "margin": 8,
                "bottomGap": 0,
                "transparency": 0.8,
                "followInterfaceStyle": false,
                "autoHide": false,
                "smartAutoHide": true,
                "useOverlayLayer": false,
                "editOnRightClick": true,
                "showOnFullscreen": false,
                "openOnOverview": true,
                "groupByApp": true,
                "separatePinnedAndRunningApps": true,
                "restoreSpecialWorkspaceOnClick": false,
                "isolateDisplays": false,
                "indicatorStyle": "circle",
                "borderEnabled": true,
                "borderColor": "surfaceText",
                "borderOpacity": 0.2,
                "borderThickness": 1,
                "launcherEnabled": false,
                "launcherLogoMode": "os",
                "launcherLogoCustomPath": "",
                "launcherLogoColorOverride": "",
                "launcherLogoSizeOffset": 0,
                "launcherLogoBrightness": 0.5,
                "launcherLogoContrast": 1,
                "maxVisibleApps": 0,
                "maxVisibleRunningApps": 0,
                "showOverflowBadge": true,
                "showTrash": false,
                "trashFileManager": "thunar",
                "trashCustomCommand": "",
                "magnification": false,
                "magnificationScale": 130,
                "magnificationProfile": "gaussian",
                "magnificationExpand": false,
                "order": [],
                "widgets": [
                  {
                    "enabled": true,
                    "id": "dock_launcher",
                    "widgetId": "dockLauncher"
                  },
                  {
                    "appsDockColorizeActive": false,
                    "enabled": true,
                    "id": "dock_apps",
                    "runningAppsCurrentWorkspace": false,
                    "widgetId": "appsDock"
                  },
                  {
                    "enabled": true,
                    "id": "dock_trash",
                    "widgetId": "dockTrash"
                  }
                ]
              }
            ],
            "currentThemeCategory": "dynamic",
            "matugenScheme": "scheme-tonal-spot",
            "matugenContrast": 0,
            "matugenSpec": "dms",
            "popupTransparency": 1,
            "floatingWindowSyncGlobal": true,
            "floatingWindowTitleBars": true,
            "dmsWindowsFloatingSeeded": [
              "niri"
            ],
            "widgetColorMode": "default",
            "controlCenterTileColorMode": "primary",
            "buttonColorMode": "primary",
            "containerSaturation": 100,
            "niriLayoutGapsOverride": -1,
            "niriLayoutRadiusOverride": -1,
            "audioShowStreamDevices": false,
            "reduceMotion": false,
            "springBounce": 0,
            "motionEffect": 1,
            "m3ElevationIntensity": 12,
            "m3ElevationOpacity": 75,
            "m3ElevationLightDirection": "autoBar",
            "barElevationEnabled": true,
            "blurEnabled": false,
            "blurBorderSeeded": true,
            "blurForegroundLayers": true,
            "foregroundLayerTransparency": 1,
            "blurLayerOutlineOpacity": 0.12,
            "focusRingEnabled": false,
            "focusRingWidth": 1.5,
            "focusRingColor": "primary",
            "blurredWallpaperLayer": false,
            "blurWallpaperOnOverview": true,
            "controlCenterIconScale": 1,
            "controlCenterWidgets": [
              {
                "col": 0,
                "enabled": true,
                "h": 1,
                "id": "user",
                "row": 0,
                "w": 5
              },
              {
                "col": 5,
                "enabled": true,
                "h": 1,
                "id": "settings",
                "row": 0,
                "small": true,
                "w": 1
              },
              {
                "col": 6,
                "enabled": true,
                "h": 1,
                "id": "lock",
                "row": 0,
                "small": true,
                "w": 1
              },
              {
                "col": 7,
                "enabled": true,
                "h": 1,
                "id": "power",
                "row": 0,
                "small": true,
                "w": 1
              },
              {
                "col": 0,
                "enabled": true,
                "h": 1,
                "id": "brightnessSlider",
                "row": 1,
                "w": 4
              },
              {
                "col": 4,
                "enabled": true,
                "h": 1,
                "id": "volumeSlider",
                "row": 1,
                "w": 4
              },
              {
                "col": 0,
                "enabled": true,
                "h": 1,
                "id": "wifi",
                "row": 2,
                "w": 4
              },
              {
                "col": 4,
                "enabled": true,
                "h": 1,
                "id": "bluetooth",
                "row": 2,
                "w": 4
              },
              {
                "col": 0,
                "enabled": true,
                "h": 1,
                "id": "audioOutput",
                "row": 3,
                "w": 4
              },
              {
                "col": 4,
                "enabled": true,
                "h": 1,
                "id": "audioInput",
                "row": 3,
                "w": 4
              },
              {
                "col": 0,
                "enabled": true,
                "h": 1,
                "id": "darkMode",
                "row": 7,
                "w": 2
              },
              {
                "col": 2,
                "enabled": true,
                "h": 1,
                "id": "nightMode",
                "row": 7,
                "w": 2
              },
              {
                "col": 4,
                "enabled": true,
                "h": 1,
                "id": "doNotDisturb",
                "row": 7,
                "w": 2
              },
              {
                "col": 6,
                "enabled": true,
                "h": 1,
                "id": "idleInhibitor",
                "row": 7,
                "w": 2
              },
              {
                "col": 0,
                "enabled": true,
                "h": 1,
                "id": "battery",
                "row": 4,
                "w": 4
              },
              {
                "col": 4,
                "enabled": true,
                "h": 1,
                "id": "diskUsage",
                "row": 4,
                "showMountPath": false,
                "w": 4
              },
              {
                "col": 0,
                "enabled": true,
                "h": 1,
                "id": "runningApps",
                "row": 8,
                "small": true,
                "w": 7
              },
              {
                "col": 7,
                "enabled": true,
                "h": 1,
                "id": "edit",
                "row": 8,
                "small": true,
                "w": 1
              },
              {
                "col": 0,
                "enabled": true,
                "h": 1,
                "id": "builtin_tailscale",
                "row": 6,
                "w": 4
              },
              {
                "col": 4,
                "enabled": true,
                "h": 1,
                "id": "plugin_dankKDEConnect",
                "row": 6,
                "w": 4
              },
              {
                "col": 0,
                "enabled": true,
                "h": 1,
                "id": "plugin_quickCapture",
                "row": 5,
                "w": 4
              },
              {
                "col": 4,
                "enabled": true,
                "h": 1,
                "id": "builtin_vpn",
                "row": 5,
                "w": 4
              }
            ],
            "workspaceNameIcons": {},
            "scrollTitleEnabled": true,
            "audioVisualizerEnabled": true,
            "bluetoothMprisEnabled": true,
            "launcherEnterAction": "focus",
            "rememberLastMode": true,
            "niriOverviewOverlayEnabled": true,
            "niriOverviewLauncherStyle": "full",
            "dankLauncherV2Size": "compact",
            "dankLauncherV2BorderEnabled": false,
            "dankLauncherV2IncludeFilesInAll": true,
            "dankLauncherV2IncludeFoldersInAll": true,
            "launcherUseOverlayLayer": false,
            "launcherStyle": "full",
            "avatarRing": "primary",
            "spotlightBarShowModeChips": true,
            "dashTabPosition": "auto",
            "dashTabsEvenlySpaced": true,
            "dashTabs": [
              {
                "enabled": true,
                "id": "overview"
              },
              {
                "enabled": true,
                "id": "media"
              },
              {
                "enabled": true,
                "id": "wallpaper"
              },
              {
                "enabled": true,
                "id": "weather"
              },
              {
                "enabled": true,
                "id": "wellbeing"
              },
              {
                "enabled": true,
                "id": "notifications"
              }
            ],
            "dashCards": [
              {
                "col": 0,
                "h": 1,
                "id": "cpu",
                "row": 0,
                "w": 2
              },
              {
                "col": 0,
                "h": 1,
                "id": "memory",
                "row": 1,
                "w": 2
              },
              {
                "col": 0,
                "h": 1,
                "id": "disk",
                "row": 2,
                "w": 2
              },
              {
                "col": 0,
                "h": 1,
                "id": "network",
                "row": 3,
                "w": 2
              },
              {
                "col": 0,
                "h": 1,
                "id": "battery",
                "row": 4,
                "w": 2
              },
              {
                "col": 2,
                "h": 3,
                "id": "calendar",
                "row": 1,
                "w": 3
              },
              {
                "col": 2,
                "h": 1,
                "id": "clock",
                "row": 0,
                "w": 2
              },
              {
                "col": 2,
                "h": 1,
                "id": "media",
                "row": 4,
                "w": 3
              },
              {
                "col": 4,
                "h": 1,
                "id": "weather",
                "row": 0,
                "w": 1
              },
              {
                "col": 5,
                "h": 5,
                "id": "notifications",
                "row": 0,
                "w": 3
              }
            ],
            "dashOptions": {
              "battery": {
                "health": true
              },
              "calendar": {
                "weekends": true
              },
              "clock": {
                "tone": ""
              },
              "disk": {
                "io": true
              },
              "media": {
                "animatedArt": true,
                "artStyle": "cookie",
                "titleFont": "ui"
              },
              "memory": {
                "swap": true
              },
              "overview": {
                "panelColumns": 8
              },
              "wallpaper": {
                "layout": "carousel"
              },
              "weather": {
                "city": true,
                "widgets": [
                  {
                    "city": true,
                    "col": 0,
                    "h": 2,
                    "id": "conditions",
                    "row": 0,
                    "tone": "primary",
                    "w": 2
                  },
                  {
                    "col": 2,
                    "forecast": "chart",
                    "h": 2,
                    "id": "hourly",
                    "row": 0,
                    "w": 2
                  },
                  {
                    "col": 0,
                    "h": 2,
                    "id": "sun",
                    "row": 2,
                    "tone": "",
                    "w": 1
                  },
                  {
                    "col": 1,
                    "h": 2,
                    "id": "moon",
                    "row": 2,
                    "tone": "",
                    "w": 1
                  },
                  {
                    "col": 2,
                    "graphics": true,
                    "h": 2,
                    "id": "humidity",
                    "row": 2,
                    "tone": "",
                    "w": 1
                  },
                  {
                    "col": 3,
                    "graphics": true,
                    "h": 2,
                    "id": "wind",
                    "row": 2,
                    "tone": "",
                    "w": 1
                  },
                  {
                    "graphics": true,
                    "h": 2,
                    "id": "precipitation",
                    "tone": "",
                    "w": 1
                  },
                  {
                    "graphics": true,
                    "h": 2,
                    "id": "visibility",
                    "tone": "",
                    "w": 1
                  },
                  {
                    "graphics": true,
                    "h": 2,
                    "id": "uv",
                    "tone": "",
                    "w": 1
                  },
                  {
                    "graphics": true,
                    "h": 2,
                    "id": "pressure",
                    "tone": "",
                    "w": 1
                  }
                ]
              }
            },
            "networkPreference": "ethernet",
            "iconThemePerMode": false,
            "cursorSettings": {
              "niri": {
                "hideAfterInactiveMs": 3000,
                "hideWhenTyping": true
              },
              "size": 24,
              "theme": "System Default"
            },
            "soundLogin": true,
            "acMonitorTimeout": 300,
            "acLockTimeout": 180,
            "acSuspendTimeout": 600,
            "acPostLockMonitorTimeout": 15,
            "lockBeforeSuspend": true,
            "terminalsAlwaysDark": true,
            "terminalOpacity": 80,
            "terminalPalette": "default",
            "muxType": "zellij",
            "notificationOverlayEnabled": true,
            "lockScreenPowerOffMonitorsOnLock": true,
            "lockAtStartup": false,
            "lockScreenVideoEnabled": false,
            "notificationCompactMode": true,
            "notificationShowTimeoutBar": true,
            "notificationPopupPosition": 0,
            "notificationFocusedMonitor": true,
            "osdAlwaysShowValue": false,
            "osdMediaPlaybackEnabled": true,
            "osdPowerProfileEnabled": true,
            "osdWorkspaceEnabled": false,
            "displayProfileAutoSelect": true,
            "connectedFrameBarStyleBackups": {},
            "barConfigs": [
              {
                "attachToScreenEdge": false,
                "autoHide": true,
                "autoHideDelay": 250,
                "autoHideStrict": false,
                "barInsetPadding": -1,
                "batteryColorMode": "theme",
                "borderEnabled": true,
                "borderOpacity": 0.1,
                "centerWidgets": [
                  "music",
                  {
                    "clockCompactMode": true,
                    "enabled": true,
                    "id": "clock"
                  },
                  "weather"
                ],
                "dot": false,
                "enabled": true,
                "followInterfaceStyle": true,
                "fontScale": 1,
                "gothCornerRadiusOverride": false,
                "gothCornersEnabled": false,
                "hoverPopouts": false,
                "id": "default",
                "innerPadding": 2,
                "island": true,
                "islandAlongOffset": 0,
                "islandCompactThickness": 38,
                "islandFloating": true,
                "islandHighContrast": false,
                "islandHomeClockDisplay": "time",
                "islandHomeCompactTight": true,
                "islandHomeLayout": [
                  {
                    "enabled": true,
                    "id": "media"
                  },
                  {
                    "enabled": true,
                    "id": "clock"
                  },
                  {
                    "enabled": true,
                    "id": "notifications"
                  },
                  {
                    "enabled": true,
                    "id": "privacy"
                  },
                  {
                    "enabled": false,
                    "id": "workspaces"
                  },
                  {
                    "enabled": false,
                    "id": "weather"
                  },
                  {
                    "enabled": false,
                    "id": "status"
                  },
                  {
                    "enabled": false,
                    "id": "volume"
                  },
                  {
                    "enabled": false,
                    "id": "brightness"
                  },
                  {
                    "enabled": false,
                    "id": "tray"
                  }
                ],
                "islandInteractionMode": "click",
                "islandMediaAutoSwitch": false,
                "islandMediaClockVisible": false,
                "islandNotch": true,
                "islandNotificationExpand": false,
                "islandNotificationPopups": false,
                "islandOuterGap": 4,
                "islandPalette": "default",
                "islandPlacement": "edge",
                "islandReserveThickness": 40,
                "islandSatelliteBackground": false,
                "islandSatelliteGap": 12,
                "islandSatelliteGothCorners": false,
                "islandSatellitePosition": "edges",
                "islandSatellitesEnabled": true,
                "islandSharedRouting": "always",
                "islandSystemOsd": true,
                "islandUseOverlayLayer": false,
                "leftWidgets": [
                  {
                    "enabled": true,
                    "id": "launcherButton",
                    "launcherLogoMode": "os",
                    "overflowMode": "bar"
                  },
                  {
                    "enabled": true,
                    "id": "workspaceSwitcher",
                    "overflowMode": "section",
                    "showOccupiedWorkspacesOnly": true,
                    "showWorkspaceApps": false,
                    "showWorkspaceIndex": false,
                    "showWorkspaceName": false,
                    "workspaceFocusedBorderEnabled": false,
                    "workspaceIndicatorCompact": true,
                    "workspaceIndicatorRoundness": -1,
                    "workspaceIndicatorStyle": "pills"
                  },
                  {
                    "enabled": true,
                    "id": "runningApps",
                    "runningAppsCompactMode": true,
                    "runningAppsCurrentMonitor": true,
                    "runningAppsCurrentWorkspace": true,
                    "runningAppsGroupByApp": false
                  },
                  {
                    "enabled": false,
                    "focusedWindowCompactMode": true,
                    "focusedWindowShowIcon": true,
                    "focusedWindowSize": 1,
                    "id": "focusedWindow",
                    "overflowMode": "section"
                  }
                ],
                "maximizeDetection": false,
                "maximizeWidgetIcons": false,
                "maximizeWidgetText": false,
                "name": "Main Bar",
                "noBackground": false,
                "openOnOverview": true,
                "popupGapsAuto": false,
                "position": 0,
                "rightWidgets": [
                  {
                    "enabled": true,
                    "id": "systemTray"
                  },
                  {
                    "enabled": true,
                    "id": "dankKDEConnect"
                  },
                  {
                    "enabled": false,
                    "id": "idleInhibitor"
                  },
                  {
                    "compactMode": true,
                    "enabled": false,
                    "hideWhenIdle": false,
                    "id": "network_speed_monitor"
                  },
                  {
                    "enabled": true,
                    "id": "cpuTemp",
                    "minimumWidth": true
                  },
                  {
                    "enabled": false,
                    "id": "notepadButton"
                  },
                  {
                    "id": "quickCapture",
                    "enabled": true
                  },
                  {
                    "enabled": true,
                    "id": "clipboard"
                  },
                  {
                    "enabled": true,
                    "id": "notificationButton"
                  },
                  {
                    "batteryStyle": "icon",
                    "enabled": true,
                    "id": "battery",
                    "showBatteryPercent": true,
                    "showBatteryPercentOnlyOnBattery": false,
                    "showBatteryPowerCharging": false,
                    "showBatteryTime": false
                  },
                  {
                    "enabled": false,
                    "id": "powerMenuButton"
                  },
                  {
                    "enabled": true,
                    "id": "controlCenterButton",
                    "overflowMode": "bar",
                    "showScreenSharingIcon": false
                  }
                ],
                "screenPreferences": [
                  "all"
                ],
                "scrollEnabled": false,
                "shadowIntensity": 0,
                "shadowOpacity": 60,
                "showOnLastDisplay": false,
                "showOnWindowsOpen": true,
                "spacing": 0,
                "squareCorners": true,
                "transparency": 1,
                "visible": true,
                "widgetFollowInterfaceStyle": true,
                "widgetOutlineColor": "surfaceText",
                "widgetOutlineEnabled": true,
                "widgetOutlineOpacity": 0.2,
                "widgetPadding": 8,
                "widgetStyle": "segments"
              },
              {
                "attachToScreenEdge": false,
                "borderEnabled": true,
                "borderOpacity": 0.1,
                "centerWidgets": [
                  "music",
                  {
                    "clockCompactMode": true,
                    "enabled": true,
                    "id": "clock"
                  },
                  "weather"
                ],
                "dot": true,
                "enabled": false,
                "followInterfaceStyle": false,
                "fontScale": 0.8,
                "gothCornersEnabled": false,
                "id": "dot1793707104506",
                "innerPadding": 2,
                "island": false,
                "leftWidgets": [
                  {
                    "enabled": true,
                    "id": "launcherButton",
                    "launcherLogoMode": "os"
                  },
                  "workspaceSwitcher",
                  "focusedWindow"
                ],
                "name": "Dot",
                "openOnOverview": true,
                "position": 2,
                "rightWidgets": [
                  "systemTray",
                  "cpuUsage",
                  "memUsage",
                  "notificationButton",
                  "battery",
                  "controlCenterButton"
                ],
                "screenPreferences": [
                  "all"
                ],
                "shadowIntensity": 0,
                "shadowOpacity": 60,
                "showOnLastDisplay": true,
                "spacing": 0,
                "squareCorners": true,
                "transparency": 1,
                "visible": true,
                "widgetFollowInterfaceStyle": true,
                "widgetOutlineColor": "surfaceText",
                "widgetOutlineEnabled": true,
                "widgetOutlineOpacity": 0.1,
                "widgetPadding": 4
              }
            ],
            "desktopWidgetInstances": [
              {
                "config": {
                  "catSizePercent": 90,
                  "catSkin": "pixel",
                  "displayPreferences": [
                    "all"
                  ],
                  "mouseEnabled": true,
                  "pixelSkinColor": "pink",
                  "showOnOverlay": false,
                  "showOnOverview": false,
                  "soundEnabled": false
                },
                "enabled": true,
                "id": "dw_1793783266690_1dnkoluia",
                "name": "Bongo Cat",
                "widgetType": "bongoCat"
              }
            ],
            "builtInPluginSettings": {
              "dms_clipboard_search": {
                "trigger": "cb"
              },
              "dms_power": {
                "trigger": "pw"
              },
              "dms_qr_generator": {
                "trigger": "qrg"
              },
              "dms_settings_search": {
                "trigger": "?"
              },
              "dms_vpn": {
                "trigger": "vpn"
              }
            },
            "clipboardClickToPaste": true,
            "clipboardEnterToPaste": true,
            "clipboardSize": "compact",
            "clipboardVisibleEntryActions": [
              "pin",
              "edit",
              "delete",
              "paste"
            ],
            "launcherPluginVisibility": {
              "recentFiles": {
                "allowWithoutTrigger": true
              }
            },
            "frameEnabled": false,
            "barInsetPaddingShared": -1,
            "barInsetPaddingSyncAll": true,
            "configVersion": 42
          }
        '';

        session = builtins.fromJSON ''
          {
            "wallpaperCyclingEnabled": false,
            "wallpaperCyclingRecursive": true,
            "wallpaperCyclingFolderPath": "/home/tux/Pictures/Wallpapers",
            "wallpaperCyclingRandom": true,
            "wallpaperTransition": "random",
            "terminalOverride": "alacritty",
            "dockPins": {
              "dock": [
                "Alacritty",
                "firefox",
                "thunar",
                "net.lutris.Lutris",
                "nvim",
                "dev.zed.Zed"
              ]
            },
            "desktopWidgetInstancePositions": {
              "dw_1793783266690_1dnkoluia": {
                "eDP-1": {
                  "anchorX": "end",
                  "anchorY": "end",
                  "height": 200,
                  "width": 200,
                  "x": 24,
                  "y": 24
                }
              },
              "lw_1793704622837_vnekvv91t": {
                "_synced": {
                  "x": 0.016,
                  "y": 0.028
                }
              }
            },
            "configVersion": 7
          }
        '';

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

{inputs, ...}: {
  flake-file.inputs = {
    dms-plugin-registry = {
      url = "github:duxlabs-dev/dux-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.niri-de.dms.plugins = let
    commonDmsPluginsConfig = {
      programs.dank-material-shell.plugins = {
        dankKDEConnect = {
          enable = true;
          settings = builtins.fromJSON ''
            {
              "enabled": true,
              "enableChargingAnimation": false,
              "showDevicePlaceholder": true
            }
          '';
        };

        quickCapture = {
          enable = true;
          settings = builtins.fromJSON ''
            {
              "enabled": true,
              "saveFilenamePattern": "%Y-%m-%d_%H-%M-%S",
              "postNotification": "toast",
              "show_shortcut_hints": true
            }
          '';
        };

        recentFiles = {
          enable = true;
          settings = builtins.fromJSON ''
            {
              "enabled": true,
              "trigger": "rf",
              "noTrigger": false,
              "settingsVersion": 1
            }
          '';
        };

        calculator = {
          enable = true;
          settings = builtins.fromJSON ''
            {
              "enabled": true,
              "trigger": "="
            }
          '';
        };

        dankNotepadModule = {
          enable = true;
          settings = builtins.fromJSON ''
            {
              "enabled": true
            }
          '';
        };

        dankActions = {
          enable = true;
          settings = builtins.fromJSON ''
            {
              "enabled": true
            }
          '';
        };

        nixPackageRunner = {
          enable = true;
          settings = builtins.fromJSON ''
            {
              "enabled": true,
              "trigger": "nix",
              "runInTerminal": true
            }
          '';
        };

        emojiLauncher = {
          enable = true;
          settings = builtins.fromJSON ''
            {
              "enabled": true,
              "trigger": "emo",
              "pasteOnSelect": true
            }
          '';
        };

        dankGifSearch = {
          enable = true;
          settings = builtins.fromJSON ''
            {
              "enabled": true,
              "trigger": "gif",
              "pasteUrlOnly": true
            }
          '';
        };

        dankStickerSearch = {
          enable = true;

          settings = builtins.fromJSON ''
            {
              "enabled": true,
              "trigger": "sti",
              "pasteUrlOnly": true
            }
          '';
        };

        wallpaperBing = {
          enable = true;

          settings = builtins.fromJSON ''
            {
              "enabled": true,
              "notifications": false
            }
          '';
        };

        bongoCat = {
          enable = true;

          settings = builtins.fromJSON ''
            {
              "enabled": true,
              "catSkin": "pixel",
              "catSizePercent": 90,
              "pixelSkinColor": "pink",
              "mouseEnabled": true
            }
          '';
        };
      };
    };

    mkCommonDmsPluginsExtraPackages = pkgs: [
      pkgs.inotify-tools
      pkgs.evtest
      pkgs.libinput
      pkgs.gpu-screen-recorder
      pkgs.wf-recorder
      pkgs.tesseract
    ];
  in {
    nixos = {pkgs, ...}: {
      imports = [
        inputs.dms-plugin-registry.nixosModules.default
        commonDmsPluginsConfig
      ];

      environment.systemPackages = mkCommonDmsPluginsExtraPackages pkgs;
    };

    homeManager = {pkgs, ...}: {
      imports = [
        inputs.dms-plugin-registry.homeModules.default
        commonDmsPluginsConfig
      ];

      home.packages = mkCommonDmsPluginsExtraPackages pkgs;
    };

    user = {
      extraGroups = ["input"];
    };
  };
}

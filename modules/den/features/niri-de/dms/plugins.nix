{inputs, ...}: {
  flake-file.inputs = {
    dms-plugin-registry = {
      url = "github:duxlabs-dev/dux-plugin-registry";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.niri-de.dms.plugins = let
    sharedModule = {
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

    mkCommonPkgs = pkgs: [
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
        sharedModule
      ];

      environment.systemPackages = mkCommonPkgs pkgs;
    };

    homeManager = {pkgs, ...}: {
      imports = [
        inputs.dms-plugin-registry.homeModules.default
        sharedModule
      ];

      home.packages = mkCommonPkgs pkgs;
    };

    user = {
      extraGroups = ["input"];
    };
  };
}

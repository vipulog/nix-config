{
  den.aspects.nix = let
    sharedModule = {
      nix.settings = {
        connect-timeout = 5;
        fallback = true;
        experimental-features = ["nix-command" "flakes"];

        min-free = 128000000;
        max-free = 1000000000;

        extra-substituters = [
          "https://nix-community.cachix.org"
        ];

        extra-trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        ];
      };
    };
  in {
    os = {
      imports = [sharedModule];
    };

    nixos = {
      nix = {
        settings = {
          trusted-users = ["root" "@wheel"];
        };

        gc = {
          automatic = true;
          options = "--delete-older-than 14d";
          dates = ["Sun 03:00"];
          persistent = true;
          randomizedDelaySec = "15min";
        };

        optimise = {
          automatic = true;
          dates = ["Mon 03:00"];
          persistent = true;
          randomizedDelaySec = "15min";
        };
      };
    };

    darwin = {
      nix = {
        settings = {
          trusted-users = ["root" "@admin"];
        };

        gc = {
          automatic = true;
          options = "--delete-older-than 14d";

          interval = [
            {
              Weekday = 0;
              Hour = 3;
              Minute = 0;
            }
          ];
        };

        optimise = {
          automatic = true;

          interval = [
            {
              Weekday = 1;
              Hour = 3;
              Minute = 0;
            }
          ];
        };
      };
    };

    homeManager = {
      lib,
      pkgs,
      ...
    }: {
      imports = [sharedModule];

      nix = {
        package = lib.mkDefault pkgs.nix;

        gc = {
          automatic = true;
          options = "--delete-older-than 14d";
          dates = ["Sat 03:00"];
          persistent = true;
          randomizedDelaySec = "1h";
        };
      };
    };

    persist-user = {
      directories = {
        ".local/state/nix".enable = true;
        ".cache/nix".enable = true;
      };
    };
  };
}

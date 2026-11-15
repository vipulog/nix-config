{inputs, ...}: {
  flake-file.inputs = {
    my-templates = {
      url = "github:vipulog/nix-templates";

      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        import-tree.follows = "import-tree";
        git-hooks-nix.follows = "git-hooks-nix";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
  };

  den.aspects.nix = let
    sharedModule = {
      nix = {
        registry.my-templates.flake = inputs.my-templates;

        settings = {
          connect-timeout = 5;
          fallback = true;
          experimental-features = ["nix-command" "flakes"];

          min-free = 128000000;
          max-free = 1000000000;

          extra-substituters = [
            "https://nix-community.cachix.org"
            "https://redirector.cachix.org"
            "https://nvf.cachix.org"
          ];

          extra-trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "redirector.cachix.org-1:lx9grKUxrkiq/H1qkIV/oEgRB9SmYGD2Yg37fHs6TlE="
            "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
          ];
        };
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

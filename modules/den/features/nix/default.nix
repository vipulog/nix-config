{inputs, ...}: {
  flake-file.inputs = {
    my-templates.url = "github:vipulog/nix-templates";
  };

  den.aspects.nix = {user}: {
    nixos = {
      nix = {
        settings = {
          connect-timeout = 5;
          fallback = true;
          experimental-features = ["nix-command" "flakes"];

          auto-optimise-store = true;
          min-free = 128000000;
          max-free = 1000000000;

          trusted-users = [
            "root"
            "@wheel"
          ];

          substituters = [
            "https://cache.nixos.org/"
            "https://nix-community.cachix.org"
            "https://redirector.cachix.org"
            "https://nvf.cachix.org"
          ];

          trusted-public-keys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "redirector.cachix.org-1:lx9grKUxrkiq/H1qkIV/oEgRB9SmYGD2Yg37fHs6TlE="
            "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
          ];
        };

        optimise = {
          automatic = true;
          dates = ["weekly"];
          persistent = true;
          randomizedDelaySec = "1h";
        };

        registry = {
          my-templates.flake = inputs.my-templates;
        };
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        ".local/state/nix"
        ".cache/nix"
      ];
    };
  };
}

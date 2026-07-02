{inputs, ...}: {
  flake-file.inputs = {
    my-templates = {
      url = "github:vipulog/nix-templates";
    };
  };

  den.aspects.nix = {
    nixos = {
      nix = {
        settings = {
          connect-timeout = 5;
          fallback = true;
          experimental-features = ["nix-command" "flakes"];

          auto-optimise-store = true;
          min-free = 128000000;
          max-free = 1000000000;

          substituters = [
            "https://cache.nixos.org/"
            "https://nix-community.cachix.org"
          ];

          trusted-public-keys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
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
  };
}

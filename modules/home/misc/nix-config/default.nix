{
  config,
  pkgs,
  inputs,
  namespace,
  lib,
  ...
}: let
  cfg = config.${namespace}.misc.nix;
  sopsEnabled = config.${namespace}.misc.sops.enable;
in {
  options.${namespace}.misc.nix = {
    enable = lib.mkEnableOption "nix";
  };

  config = lib.mkIf cfg.enable (
    lib.mkMerge [
      {
        nix = {
          package = lib.mkForce pkgs.nix;

          settings = {
            connect-timeout = 5;
            fallback = true;
            auto-optimise-store = true;
            min-free = 128000000;
            max-free = 1000000000;
            experimental-features = ["nix-command" "flakes"];

            substituters = [
              "https://cache.nixos.org/"
              "https://nix-community.cachix.org"
              "https://cache.garnix.io"
            ];

            trusted-public-keys = [
              "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
              "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
              "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbCHOoE/BkTl+/1ow94="
            ];
          };

          gc = {
            automatic = true;
            dates = ["weekly"];
            persistent = true;
            randomizedDelaySec = "1h";
          };

          registry = {
            my-templates.flake = inputs.my-templates;
          };
        };
      }

      (lib.mkIf sopsEnabled (let
        secretName = "nix-extra-access-tokens";
      in {
        sops.secrets.${secretName} = {
          sopsFile = inputs.my-secrets + "/secrets/sops/shared.yaml";
        };

        nix.extraOptions = ''
          !include ${config.sops.secrets.${secretName}.path}
        '';
      }))
    ]
  );
}

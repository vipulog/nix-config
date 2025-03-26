{
  inputs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.system.nix;
in {
  options.internal.system.nix = {
    enable = mkEnableOption "nix configuration";
  };

  config = mkIf cfg.enable {
    nix = {
      # This will add each flake input as a registry
      # To make nix3 commands consistent with your flake
      registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

      # This will add your inputs to the system's legacy channels
      # Making legacy nix commands consistent as well, awesome!
      nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

      settings = {
        # See https://jackson.dev/post/nix-reasonable-defaults/
        connect-timeout = 5;
        log-lines = 25;

        min-free = 10 * 1024 * 1024 * 1024; # 10GB
        max-free = 50 * 1024 * 1024 * 1024; # 50GB

        auto-optimise-store = true;
        warn-dirty = false;

        keep-outputs = true;

        experimental-features = [
          "nix-command"
          "flakes"
        ];

        trusted-users = [
          "root"
          "@wheel"
        ];
      };
    };
  };
}

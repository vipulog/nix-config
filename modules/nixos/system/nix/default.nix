{
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
      # generateRegistryFromInputs = true;
      # generateNixPathFromInputs = true;
      # linkInputs = true;

      settings = {
        # See https://jackson.dev/post/nix-reasonable-defaults/
        connect-timeout = 5;
        log-lines = 25;

        min-free = 10 * 1024 * 1024 * 1024; # 10GB
        max-free = 50 * 1024 * 1024 * 1024; # 50GB

        auto-optimise-store = true;
        warn-dirty = false;

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

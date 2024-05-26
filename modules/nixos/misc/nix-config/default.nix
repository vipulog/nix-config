{
  config,
  inputs,
  namespace,
  lib,
  ...
}: let
  cfg = config.${namespace}.misc.nix;
in {
  options.${namespace}.misc.nix = {
    enable = lib.mkEnableOption "nix";
  };

  config = lib.mkIf cfg.enable {
    nix = {
      settings = {
        connect-timeout = 5;
        fallback = true;
        auto-optimise-store = true;
        min-free = 128000000;
        max-free = 1000000000;
        experimental-features = ["nix-command" "flakes"];
        trusted-users = ["@wheel"];
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
}

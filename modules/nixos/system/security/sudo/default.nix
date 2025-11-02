{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.system.security.sudo;
in {
  options.${namespace}.system.security.sudo = {
    enable = lib.mkEnableOption "sudo";

    lecture = lib.mkOption {
      type = lib.types.enum ["never" "always" "once"];
      default = "never";
      description = "Controls when the sudo lecture is displayed.";
    };

    pwFeedback = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable password input feedback (shows asterisks while typing).";
    };

    timestampTimeout = lib.mkOption {
      type = lib.types.int;
      default = 10;
      description = "The time (in minutes) before sudo requires the password again.";
    };
  };

  config = lib.mkIf cfg.enable {
    security.sudo.extraConfig = lib.mkMerge [
      "Defaults lecture=${cfg.lecture}"
      (lib.optionalString cfg.pwFeedback "Defaults pwfeedback")
      "Defaults timestamp_timeout=${toString cfg.timestampTimeout}"
    ];
  };
}

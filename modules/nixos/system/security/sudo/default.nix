{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.system.security.sudo;
in {
  options.internal.system.security.sudo = {
    enable = mkEnableOption "sudo configuration";

    lecture = mkOption {
      type = types.enum [
        "never"
        "always"
        "once"
      ];
      default = "never";
      description = "Controls when the sudo lecture is displayed.";
    };

    pwFeedback = mkOption {
      type = types.bool;
      default = true;
      description = "Enable password input feedback (shows asterisks while typing).";
    };

    timestampTimeout = mkOption {
      type = types.int;
      default = 60;
      description = "The time (in minutes) before sudo requires the password again.";
    };
  };

  config = mkIf cfg.enable {
    security.sudo.extraConfig = mkMerge [
      "Defaults lecture=${cfg.lecture}"
      (optionalString cfg.pwFeedback "Defaults pwfeedback")
      "Defaults timestamp_timeout=${toString cfg.timestampTimeout}"
    ];
  };
}

{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.de.niri;
in {
  options.internal.de.niri = {
    outputs = mkOption {
      type = types.attrsOf types.anything;
      default = {};
      description = "Configuration for output devices.";
    };
  };

  config = mkIf cfg.enable {
    programs.niri.settings = {
      outputs = cfg.outputs;
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
      environment = {
        DISPLAY = ":0";
      };
    };
  };
}

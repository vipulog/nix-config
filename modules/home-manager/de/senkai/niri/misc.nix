{
  lib,
  config,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  options.internal.de.senkai = {
    outputs = mkOption {
      type = types.attrsOf types.anything;
      default = {};
      description = "Configuration for output devices.";
    };
  };

  config = mkIf senkaiCfg.enable {
    programs.niri.settings = {
      outputs = senkaiCfg.outputs;
      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
      environment = {
        DISPLAY = ":0";
      };
    };
  };
}

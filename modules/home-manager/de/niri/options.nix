{lib, ...}:
with lib; {
  options.internal.de.niri = {
    enable = mkEnableOption "niri";

    outputs = mkOption {
      type = types.attrsOf types.anything;
      default = {};
      description = "Configuration for output devices.";
    };
  };
}

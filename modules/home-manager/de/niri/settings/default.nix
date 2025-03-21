{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.de.niri;
in {
  imports = [
    ./keybindings.nix
    ./layout.nix
    ./window-rules.nix
    ./startup.nix
  ];

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

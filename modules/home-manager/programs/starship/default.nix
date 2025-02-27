{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.programs.starship;
in {
  options.internal.programs.starship = {
    enable = mkEnableOption "starship";
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      settings = builtins.fromTOML (builtins.readFile ./config.toml);
    };
  };
}

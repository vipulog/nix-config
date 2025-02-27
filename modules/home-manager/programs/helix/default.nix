{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.internal.programs.helix;
in {
  options.internal.programs.helix = {
    enable = mkEnableOption "helix";
  };

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        editor.cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
      };
    };
  };
}

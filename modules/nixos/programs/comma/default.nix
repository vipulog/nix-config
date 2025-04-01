{
  config,
  lib,
  inputs,
  ...
}:
with lib; let
  cfg = config.internal.programs.comma;
in {
  imports = [inputs.nix-index-database.nixosModules.nix-index];

  options.internal.programs.comma = {
    enable = mkEnableOption "comma";
  };

  config = mkIf cfg.enable {
    programs.nix-index-database.comma.enable = true;
  };
}

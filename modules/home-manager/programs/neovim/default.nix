{
  self',
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.internal.programs.neovim;
in {
  options.internal.programs.neovim = {
    enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable {
    home.packages = [self'.packages.neovim];
  };
}

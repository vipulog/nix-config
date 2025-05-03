{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  cfg = config.internal.de.niri;
in {
  imports = [
    inputs.niri.nixosModules.niri
  ];

  options.internal.de.niri = {
    enable = mkEnableOption "niri";
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [inputs.niri.overlays.niri];
    niri-flake.cache.enable = true;

    programs.niri = {
      enable = true;
      package = pkgs.niri-stable;
    };

    environment = {
      variables.NIXOS_OZONE_WL = "1";
      systemPackages = with pkgs; [
        xwayland-satellite
        wl-clipboard
      ];
    };
  };
}

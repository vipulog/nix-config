{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; let
  senkaiCfg = config.internal.de.senkai;
in {
  imports = [
    inputs.niri.nixosModules.niri
  ];

  options.internal.de.senkai = {
    enable = mkEnableOption "senkai";
  };

  config = mkIf senkaiCfg.enable {
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

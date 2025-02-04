{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.niri.nixosModules.niri];

  niri-flake.cache.enable = false;

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  environment.variables.NIXOS_OZONE_WL = "1";
  environment.systemPackages = with pkgs; [
    xwayland-satellite
    wl-clipboard
  ];
}

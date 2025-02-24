{lib, ...}: let
  username = "vipul";
in {
  imports = [
    (lib.custom.relativeToRoot "modules/nixos/optional/users/${username}")
    ./home-configuration.nix
  ];
}

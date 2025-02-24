{lib, ...}: let
  username = builtins.baseNameOf ./.;
in {
  imports = [
    (lib.custom.relativeToRoot "modules/nixos/optional/users/${username}")
    (import ./home-configuration.nix {inherit lib username;})
  ];
}

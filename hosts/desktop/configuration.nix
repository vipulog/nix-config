{
  inputs,
  lib,
  ...
}: {
  imports = lib.flatten [
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
    ./disk-config.nix
    ./users

    (map lib.custom.relativeToRoot [
      "modules/nixos/core"
      "modules/nixos/optional/tuigreet+niri.nix" # greeter + window manager
      "modules/nixos/optional/openssh.nix" # allow remote SSH access
      "modules/nixos/optional/audio.nix" # pipewire and cli controls
    ])
  ];

  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
    enableIPv6 = false;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 3;
  };

  autoLogin.enable = true;
  autoLogin.username = "vipul";

  services.tailscale.enable = true;

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}

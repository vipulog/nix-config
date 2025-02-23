{
  inputs,
  lib,
  ...
}: {
  imports = lib.flatten [
    ./hardware-configuration.nix
    inputs.disko.nixosModules.disko
    ./disk-config.nix
    ./homes

    (map lib.custom.relativeToRoot [
      "modules/nixos/core"
      "modules/nixos/users/vipul.nix"
      "modules/nixos/optional/tuigreet+niri.nix" # greeter + window manager
      "modules/nixos/optional/openssh.nix" # allow remote SSH access
      "modules/nixos/optional/audio.nix" # pipewire and cli controls
      "modules/custom/options/auto-login.nix"
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

  services.tailscale.enable = true;

  customOptions = {
    autoLogin = {
      enable = true;
      username = "vipul";
    };
  };

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.05";
}

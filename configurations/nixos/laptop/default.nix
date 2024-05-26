{
  inputs,
  namespace,
  rootPath,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.dell-latitude-7490
  ];

  config = {
    ${namespace} = {
      roles = {
        workstation.enable = true;
        gaming.enable = true;
      };

      misc.disko.presets.single-disk-ext4.device = "/dev/nvme0n1";
    };

    home-manager.users.vipul =
      rootPath + "/configurations/home/vipul_laptop";

    # Disable touch screen input
    services.udev.extraRules = ''
      ATTRS{name}=="ELAN900C:00 04F3:25A2", ENV{ID_INPUT_TOUCHSCREEN}="0", ENV{ID_INPUT}="0"
    '';

    # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "24.11";
  };
}

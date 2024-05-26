{
  namespace,
  rootPath,
  ...
}: {
  imports = [./hardware-configuration.nix];

  config = {
    ${namespace} = {
      roles.workstation.enable = true;
      misc.disko.presets.single-disk-ext4.device = "/dev/sda/";
    };

    home-manager.users.vipul =
      rootPath + "/configurations/home/vipul_desktop";

    # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "24.11";
  };
}

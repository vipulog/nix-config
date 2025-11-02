{
  namespace,
  rootPath,
  ...
}: {
  imports = [./hardware-configuration.nix];

  config = {
    system.stateVersion = "24.11";

    ${namespace} = {
      roles.workstation.enable = true;
      misc.disko.presets.single-disk-ext4.device = "/dev/sda/";
    };

    home-manager.users.vipul =
      rootPath + "/configurations/home/vipul_desktop";
  };
}

{ pkgs, username, home-manager, ... }: {

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users.${username}.extraGroups = [ "libvirtd" ];

  home-manager.users.${username} = {
    dconf.settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = [ "qemu:///system" ];
        uris = [ "qemu:///system" ];
      };
    };
  };
}

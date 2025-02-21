{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = ["vipul"];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}

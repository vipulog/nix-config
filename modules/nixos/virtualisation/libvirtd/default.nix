{
  lib,
  config,
  namespace,
  ...
}: let
  cfg = config.${namespace}.virtualisation.libvirtd;
in {
  options.${namespace}.virtualisation.libvirtd = {
    enable = lib.mkEnableOption "libvirtd";
  };

  config = lib.mkIf cfg.enable {
    virtualisation = {
      libvirtd.enable = true;
      spiceUSBRedirection.enable = true;
    };

    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["vipul"];
  };
}

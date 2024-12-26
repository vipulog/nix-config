{ pkgs, home-manager, username, ... }: {

  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix

    ../../environment/gnome
    ../../theme/winter-forest

    ../../extras/awesome_nix.nix
    ../../extras/awesome_shell.nix
    ../../extras/common_cli_tools.nix
    ../../extras/cool_cli_tools.nix
    ../../extras/dev_tools.nix

    ../../services/tailscale.nix

    ../../virtualization/virt-manager.nix
  ];

  #----Host specific config ----
  # Hide mei logs from tty
  boot.blacklistedKernelModules = [ "mei" "mei_me" ];

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      androidStudioPackages.stable
      brave
      librewolf
      gimp
    ];
  };
}

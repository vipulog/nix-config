{ mylib, pkgs, home-manager, username, ... }: {
  imports = [
    ./hardware-configuration.nix

    ../../programs/git.nix
    ../../programs/kitty.nix
    ../../programs/vscode.nix

    ../../services/tailscale.nix
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

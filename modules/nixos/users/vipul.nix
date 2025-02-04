{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups:
    builtins.filter
    (group: builtins.hasAttr group config.users.groups)
    groups;
in {
  users.users.vipul = {
    home = "/home/vipul";
    isNormalUser = true;
    initialPassword = "1";
    shell = pkgs.zsh;

    extraGroups = lib.flatten [
      "wheel"
      (ifTheyExist [
        "audio"
        "video"
        "docker"
        "git"
        "networkmanager"
      ])
    ];
  };

  programs.zsh = {
    enable = true;
    # https://github.com/nix-community/home-manager/issues/108
    enableCompletion = false;
  };
}

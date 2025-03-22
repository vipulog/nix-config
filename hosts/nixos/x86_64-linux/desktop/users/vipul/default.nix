{pkgs, ...}: {
  users.users.vipul = {
    isNormalUser = true;
    initialPassword = "1";
    shell = pkgs.zsh;
    extraGroups = ["wheel"];
  };

  home-manager.users.vipul = import ./home;
}

{ username, home-manager, ... }: {
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "hm-backup";

    users.${username}.home = {
      username = "${username}";
      homeDirectory = "/home/${username}";
      stateVersion = "23.11";
    };
  };
}

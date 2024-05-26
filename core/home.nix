{ username, home-manager, config, ... }: {
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    backupFileExtension = "hm-backup";

    users.${username} = { config, ... }:
      let
        c = config.xdg.configHome;
        cache = config.xdg.cacheHome;
      in
      {
        home = {
          username = "${username}";
          homeDirectory = "/home/${username}";
          stateVersion = "23.11";

          # environment variables that always set at login
          sessionVariables = {
            # clean up ~
            LESSHISTFILE = cache + "/less/history";
            LESSKEY = c + "/less/lesskey";
          };
        };
      };
  };
}

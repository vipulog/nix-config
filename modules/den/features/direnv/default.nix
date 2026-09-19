{
  den.aspects.direnv = {
    homeManager = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };

    persist-user = {
      directories = [
        ".local/share/direnv"
      ];
    };
  };
}

{
  den.aspects.direnv = let
    sharedModule = {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
  in {
    os = {
      imports = [sharedModule];
    };

    homeManager = {
      imports = [sharedModule];
    };

    persist-user = {
      directories = {
        ".local/share/direnv".enable = true;
      };
    };
  };
}

{
  den.aspects.bat = let
    sharedModule = {
      programs.bat.enable = true;
    };
  in {
    nixos = {
      imports = [sharedModule];
    };

    darwin = {pkgs, ...}: {
      environment.systemPackages = [pkgs.bat];
    };

    homeManager = {
      imports = [sharedModule];
    };

    persist-user = {
      directories = {
        ".cache/bat".enable = true;
      };
    };
  };
}

{
  den.aspects.chromium = let
    sharedModule = {
      programs.chromium.enable = true;
    };
  in {
    nixos = {
      imports = [sharedModule];
    };

    darwin = {pkgs, ...}: {
      environment.systemPackages = [pkgs.chromium];
    };

    homeManager = {
      imports = [sharedModule];
    };
  };
}

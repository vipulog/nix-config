{
  den.aspects.zoxide = let
    flags = ["--cmd" "cd"];

    sharedModule = {
      programs.zoxide.enable = true;
    };
  in {
    nixos = {
      imports = [sharedModule];
      programs.zoxide.flags = flags;
    };

    darwin = {pkgs, ...}: {
      environment.systemPackages = [pkgs.zoxide];
    };

    homeManager = {
      imports = [sharedModule];
      programs.zoxide.options = flags;
    };

    persist-user = {
      directories = {
        ".local/share/zoxide".enable = true;
      };
    };
  };
}

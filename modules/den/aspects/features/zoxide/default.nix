{den, ...}: {
  den.aspects.zoxide = {
    host,
    user,
  }: let
    isEphemeralHost = host.hasAspect den.aspects.ephemeral-host;
  in {
    nixos = {lib, ...}: {
      config = lib.mkMerge [
        (lib.mkIf isEphemeralHost {
          preservation.preserve = {
            users = lib.mkIf (user != null) {
              ${user.name}.directories = [
                {
                  directory = ".local/share/zoxide";
                  mode = "0700";
                }
              ];
            };
          };
        })
      ];
    };

    homeManager = {
      programs.zoxide = {
        enable = true;
        options = ["--cmd" "cd"];
      };
    };
  };
}

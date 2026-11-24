{
  flake-file.inputs = {
    sable = {
      url = "github:SableClient/sable-next/v26.11.4";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.sable = {
    os = {inputs', ...}: {
      environment.systemPackages = [
        inputs'.sable.packages.sable-desktop
      ];
    };

    homeManager = {inputs', ...}: {
      home.packages = [
        inputs'.sable.packages.sable-desktop
      ];
    };

    persist-user = {
      directories = {
        ".config/moe.sable.client.electron".enable = true;
        ".local/share/moe.sable.client".enable = true;
      };
    };
  };
}

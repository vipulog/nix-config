{
  lib,
  self,
  inputs,
  namespace,
  rootPath,
  withSystem,
  ...
}: let
  configurations = mkHosts {
    desktop.system = "x86_64-linux";
    laptop.system = "x86_64-linux";
  };

  mkHosts = hostConfigs: lib.mapAttrs mkHost hostConfigs;
  mkHost = hostname: cfg: mkNixosConfiguration (cfg // {inherit hostname;});

  mkNixosConfiguration = {
    hostname,
    system,
  }: (
    withSystem system (
      ctx: (
        inputs.nixpkgs.lib.nixosSystem {
          inherit (ctx) pkgs;
          specialArgs = getMainArgs ctx hostname;
          modules = getMainModules hostname;
        }
      )
    )
  );

  getMainArgs = systemCtx: hostname: {
    inherit (systemCtx) inputs' self' pkgsStable pkgsUnstable;
    inherit inputs self namespace rootPath hostname;
  };

  getMainModules = hostname: [
    self.nixosModules.default
    ./${hostname}
  ];
in
  configurations

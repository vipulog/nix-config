{
  lib,
  self,
  inputs,
  namespace,
  rootPath,
  withSystem,
  ...
}: let
  configurations = mkHomes {
    vipul_desktop.system = "x86_64-linux";
    vipul_laptop.system = "x86_64-linux";
  };

  mkHomes = homeConfigs: lib.mapAttrs mkHome homeConfigs;
  mkHome = homename: cfg: mkHomeConfiguration (cfg // {inherit homename;});

  mkHomeConfiguration = {
    homename,
    system,
  }: (
    withSystem system (
      ctx: (
        inputs.home-manager.lib.homeManagerConfiguration {
          inherit (ctx) pkgs;
          extraSpecialArgs = getMainArgs ctx homename;
          modules = getMainModules homename;
        }
      )
    )
  );

  getMainArgs = systemCtx: homename: {
    inherit (systemCtx) inputs' self' pkgsStable pkgsUnstable;
    inherit inputs self namespace rootPath homename;
  };

  getMainModules = homename: [
    self.homeModules.default
    ./${homename}
  ];
in
  configurations

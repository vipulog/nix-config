{
  lib,
  self,
  ...
}: {
  perSystem = {pkgs, ...}: let
    inherit (pkgs.stdenv.hostPlatform) isLinux isDarwin;

    # Force full evaluation of a derivation without adding a build dependency.
    evalDrv = drv: builtins.unsafeDiscardStringContext drv.drvPath;

    nixosTargets = lib.optionalAttrs isLinux (
      lib.mapAttrs (_: cfg: evalDrv cfg.config.system.build.toplevel)
      (self.nixosConfigurations or {})
    );

    darwinTargets = lib.optionalAttrs isDarwin (
      lib.mapAttrs (_: cfg: evalDrv cfg.config.system.build.toplevel)
      (self.darwinConfigurations or {})
    );

    homeTargets = lib.pipe (self.homeConfigurations or {}) [
      (lib.filterAttrs (_: cfg:
        (isLinux && cfg.pkgs.stdenv.hostPlatform.isLinux)
        || (isDarwin && cfg.pkgs.stdenv.hostPlatform.isDarwin)))
      (lib.mapAttrs (_: cfg: evalDrv cfg.activationPackage))
    ];

    evaluatedTargets = {
      nixos = nixosTargets;
      darwin = darwinTargets;
      homes = homeTargets;
    };
  in {
    checks.eval-targets =
      pkgs.writeText
      "eval-targets.json"
      (builtins.toJSON evaluatedTargets);
  };
}

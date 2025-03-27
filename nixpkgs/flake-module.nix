{inputs, ...}: {
  perSystem = {system, ...}: {
    _module.args.pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    _module.args.pkgsStable = import inputs.nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
    };

    _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
      inherit system;
      config.allowunfree = true;
    };
  };
}

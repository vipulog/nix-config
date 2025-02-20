{
  pkgs,
  checks,
  ...
}: {
  default = pkgs.mkShell {
    inherit (checks.pre-commit-check) shellHook;
    buildInputs = checks.pre-commit-check.enabledPackages;

    packages = with pkgs; [
      helix
      nil
      nixfmt-rfc-style
    ];
  };
}

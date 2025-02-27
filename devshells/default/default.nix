{
  pkgs,
  config,
  ...
}:
pkgs.mkShell {
  packages = with pkgs; [
    helix
    nil
  ];

  shellHook = ''
    ${config.pre-commit.installationScript}
  '';
}

{
  pkgs,
  config,
  ...
}:
pkgs.mkShell {
  shellHook = ''
    ${config.pre-commit.installationScript}
  '';
}

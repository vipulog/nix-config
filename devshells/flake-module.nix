{
  perSystem = {
    pkgs,
    config,
    ...
  }: {
    devShells.default = import ./default {inherit pkgs config;};
  };
}

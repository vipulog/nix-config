{
  perSystem = {
    pkgs,
    config,
    ...
  }: let
    default = import ./default {inherit pkgs config;};
  in {
    devShells = {
      inherit default;
    };
  };
}

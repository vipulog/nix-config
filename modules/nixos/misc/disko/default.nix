{
  lib,
  inputs,
  namespace,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./presets
  ];

  options.${namespace}.misc.disko = {
    enable = lib.mkEnableOption "disko";
  };
}

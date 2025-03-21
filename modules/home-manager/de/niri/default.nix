{inputs, ...}: {
  imports = [
    inputs.niri.homeModules.niri
    ./options.nix
    ./settings
    ./stylix
  ];
}

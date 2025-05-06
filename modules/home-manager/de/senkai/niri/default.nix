{lib, ...}:
with lib; {
  imports = [
    ./keybindings.nix
    ./layout.nix
    ./window-rules.nix
    ./layer-rules.nix
    ./startup.nix
    ./misc.nix
  ];
}

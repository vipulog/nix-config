{lib, ...}:
with lib; {
  imports = [
    ./keybindings.nix
    ./layout.nix
    ./window-rules.nix
    ./startup.nix
    ./misc.nix
  ];
}

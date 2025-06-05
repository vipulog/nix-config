{lib, ...}:
with lib; {
  imports = [
    ./niri
    ./stylix
    ./swayosd
    ./mako
    ./wofi
    ./swayidle
    ./swaylock
    ./extras
  ];

  options.internal.de.senkai = {
    enable = mkEnableOption "senkai";
  };
}

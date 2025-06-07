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
    ./clipse
    ./extras
  ];

  options.internal.de.senkai = {
    enable = mkEnableOption "senkai";
  };
}

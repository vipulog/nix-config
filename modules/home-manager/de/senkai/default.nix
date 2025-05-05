{lib, ...}:
with lib; {
  imports = [
    ./niri
    ./stylix
    ./swayosd
    ./mako
    ./waybar
    ./wofi
  ];

  options.internal.de.senkai = {
    enable = mkEnableOption "senkai";
  };
}

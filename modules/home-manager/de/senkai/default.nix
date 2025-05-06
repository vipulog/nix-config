{lib, ...}:
with lib; {
  imports = [
    ./niri
    ./stylix
    ./swayosd
    ./mako
    ./waybar
    ./wofi
    ./swayidle
  ];

  options.internal.de.senkai = {
    enable = mkEnableOption "senkai";
  };
}

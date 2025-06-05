{lib, ...}:
with lib; {
  imports = [
    ./niri
    ./stylix
    ./swayosd
    ./mako
    ./wofi
    ./swayidle
    ./extras
  ];

  options.internal.de.senkai = {
    enable = mkEnableOption "senkai";
  };
}

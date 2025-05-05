{lib, ...}:
with lib; {
  imports = [
    ./niri
    ./stylix
    ./swayosd
    ./mako
    ./waybar
  ];

  options.internal.de.senkai = {
    enable = mkEnableOption "senkai";
  };
}

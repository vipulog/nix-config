{lib, ...}:
with lib; {
  imports = [
    ./niri
    ./stylix
    ./swayosd
    ./mako
  ];

  options.internal.de.senkai = {
    enable = mkEnableOption "senkai";
  };
}

{self, ...}: {
  imports = [self.homeModules.default];

  config = {
    internal = {
      home.vipul.enable = true;

      profiles = {
        development.enable = true;
        graphical.enable = true;
      };

      programs = {
        android-studio.enable = true;
        whatsapp-web.enable = true;
      };
      de.senkai = {
        enable = true;
      };
    };

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "24.11";
  };
}

{self, ...}: {
  imports = [self.homeModules.default];

  config = {
    internal = {
      home.vipul.enable = true;
      profiles.common.enable = true;
      profiles.development.enable = true;

      programs = {
        brave-browser.enable = true;
        zen-browser.enable = true;
        qutebrowser.enable = true;
      };

      de.niri = {
        enable = true;
        outputs."HDMI-A-1" = {
          scale = 1.0;
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.000;
          };
        };
      };
    };

    # The state version is required and should stay at the version you
    # originally installed.
    home.stateVersion = "24.11";
  };
}

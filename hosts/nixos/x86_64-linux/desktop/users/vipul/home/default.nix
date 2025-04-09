{self, ...}: {
  imports = [self.homeModules.default];

  config = {
    internal = {
      home.vipul.enable = true;

      de.niri = {
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

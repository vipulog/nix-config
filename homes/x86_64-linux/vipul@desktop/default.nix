{
  config = {
    internal = {
      profiles = {
        common.enable = true;
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

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    home.stateVersion = "24.11";
  };
}

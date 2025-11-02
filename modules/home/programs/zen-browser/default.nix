{
  config,
  inputs,
  namespace,
  lib,
  ...
}: let
  cfg = config.${namespace}.programs.zen-browser;
in {
  imports = [inputs.zen-browser.homeModules.beta];

  options.${namespace}.programs.zen-browser = {
    enable = lib.mkEnableOption "zen-browser";
  };

  config = lib.mkIf cfg.enable {
    programs.zen-browser = {
      enable = true;

      profiles.default = {
        id = 0;

        settings = {
          "zen.welcome-screen.seen" = true;
          "zen.view.compact.should-enable-at-startup" = false;
          "zen.view.compact.color-toolbar" = false;
          "zen.view.compact.color-sidebar" = false;
          "zen.urlbar.behavior" = "float";
          "zen.theme.use-sysyem-colors" = true;
          "zen.theme.gradient" = false;
          "zen.theme.accent-color" = "#787878";
        };
      };

      policies = {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = true;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;

        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };

        ExtensionSettings = {
          # uBlock Origin
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
            installation_mode = "force_installed";
          };

          # Privacy Badger
          "jid1-MnnxcxisBPnSXQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
            installation_mode = "force_installed";
          };

          # Bitwarden
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
            installation_mode = "force_installed";
          };

          # File Icons for Github and Gitlab
          "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/github-file-icons/latest.xpi";
            installation_mode = "force_installed";
          };
        };
      };
    };
  };
}

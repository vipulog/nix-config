{
  den.aspects.firefox = {user}: {
    homeManager = {pkgs, ...}: {
      programs.firefox = {
        enable = true;

        profiles.default = {
          isDefault = true;

          extensions = {
            packages = with pkgs.nur.repos.rycee.firefox-addons; [
              ublock-origin
              multi-account-containers
              bitwarden
              vimium
            ];
          };

          settings = {
            "browser.contentblocking.category" = "strict";
            "dom.security.https_only_mode" = true;
            "dom.security.https_only_mode_pbm" = true;
            "network.trr.mode" = 2;
            "network.trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";

            "browser.aboutwelcome.didSeeFinalScreen" = true;

            "browser.ctrlTab.sortByRecentlyUsed" = true;

            "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
            "browser.newtabpage.activity-stream.feeds.topsites" = false;
            "browser.newtabpage.activity-stream.showSponsored" = false;

            "browser.shell.checkDefaultBrowser" = false;
            "browser.startup.page" = 3;

            "datareporting.healthreport.uploadEnabled" = false;
            "datareporting.usage.uploadEnabled" = false;

            "extensions.formautofill.addresses.enabled" = false;
            "extensions.formautofill.creditCards.enabled" = false;

            "sidebar.verticalTabs" = true;
            "sidebar.verticalTabs.dragToPinPromo.dismissed" = true;
          };
        };
      };
    };

    persist = {
      preserve.users.${user.name}.directories = [
        ".config/mozilla"
        ".cache/mozilla"
      ];
    };
  };
}

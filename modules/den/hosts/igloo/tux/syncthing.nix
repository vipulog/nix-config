{
  den.aspects.igloo.tux.syncthing = {
    homeManager = {config, ...}: {
      sops.secrets.syncthing-password = {};

      services.syncthing = {
        enable = true;

        settings = {
          guiCredentials = {
            username = "tux";
            passwordFile = config.sops.secrets.syncthing-password.path;
          };

          devices = {
            "igloo".id = "56QERGR-JFANNUO-Q4RUWTF-W3QWMRT-54XRAHL-E2DEQRZ-LF727VM-F7IVRAQ";
            "np2".id = "WCL2VTA-FIYGHZ2-KAF4EDY-IVM3JDJ-5EUUGNX-5R3DP6F-ZNKEA7A-7SMNWQJ";
          };

          folders = let
            mkFolder = path: id: {
              inherit id path;
              devices = ["igloo" "np2"];

              versioning = {
                type = "simple";

                params = {
                  keep = "5";
                  cleanoutDays = "7";
                };
              };
            };
          in {
            "DCIM" = mkFolder "~/DCIM" "guvp4-i7xpn";
            "Documents" = mkFolder "~/Documents" "3n7aj-zpwlu";
            "Music" = mkFolder "~/Music" "snamy-u3fah";
            "Pictures" = mkFolder "~/Pictures" "fedze-lelvp";
            "Videos" = mkFolder "~/Videos" "7enrc-ap4hp";
            "Recordings" = mkFolder "~/Recordings" "k8vqm-r2nfd";
          };
        };
      };
    };

    persist = {
      preserve.users.tux.directories = [
        ".config/syncthing"
      ];
    };
  };
}

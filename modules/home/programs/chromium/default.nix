{
  config,
  namespace,
  lib,
  pkgs,
  ...
}: let
  cfg = config.${namespace}.programs.chromium;
  chromiumLib = import ./lib.nix {
    inherit lib;
    chromiumPackage = cfg.package;
  };
in {
  options.${namespace}.programs.chromium = {
    enable = lib.mkEnableOption "chromium";
    package = lib.mkPackageOption pkgs "ungoogled-chromium" {};
  };

  config = lib.mkIf cfg.enable {
    programs.chromium = {
      enable = true;
      inherit (cfg) package;
      dictionaries = [pkgs.hunspellDictsChromium.en_US];
      commandLineArgs = ["--custom-ntp=chrome://new-tab-page"];

      extensions = chromiumLib.createChromiumExtensions [
        {
          # ublock origin
          id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";
          sha256 = "sha256:168vr0p31sp5ffsqnrnarw6ab1m95yil4hph0xs6gjbfky7wygki";
          version = "1.65.0";
        }
        {
          # bitwarden
          id = "nngceckbapebfimnlniiiahkandclblb";
          sha256 = "sha256:06ir8maz281d4m6lqj8px6z7ii4nvp2r1p557sr41jxz941x30jr";
          version = "2025.7.0";
        }
      ];
    };
  };
}

{
  config,
  namespace,
  lib,
  pkgs,
  ...
}: let
  cfg = config.${namespace}.programs.chromium;
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
    };
  };
}

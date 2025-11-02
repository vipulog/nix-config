{
  sopsCfg,
  plainSecrets,
  ...
}: {
  config,
  namespace,
  lib,
  ...
}: let
  zenBrowserCfg = config.${namespace}.programs.zen-browser;
in {
  config = lib.mkIf (sopsCfg.enable && zenBrowserCfg.enable) {
    programs.zen-browser = {
      profiles.default.settings = {
        "services.sync.username" = plainSecrets.mozilla.username;
      };
    };
  };
}

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
  gitCfg = config.${namespace}.programs.git;
in {
  config = lib.mkIf (sopsCfg.enable && gitCfg.enable) {
    programs.git = {
      settings.user = {
        name = plainSecrets.git.vipulog.name;
        email = plainSecrets.git.vipulog.email;
      };
    };
  };
}

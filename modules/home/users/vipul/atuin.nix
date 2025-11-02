{
  username,
  sopsCfg,
  sopsFile,
  ...
}: {
  config,
  namespace,
  lib,
  ...
}: let
  atuinCfg = config.${namespace}.programs.atuin;
in {
  config = lib.mkIf (sopsCfg.enable && atuinCfg.enable) {
    sops.secrets."keys/atuin/${username}" = {
      path = "${config.home.homeDirectory}/.local/share/atuin/key";
      inherit sopsFile;
    };
  };
}
